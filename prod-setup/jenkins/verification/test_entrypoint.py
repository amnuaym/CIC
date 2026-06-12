import os
import sys
import shutil
import tempfile
import subprocess
from pathlib import Path

# Paths
WORKSPACE_DIR = Path(__file__).resolve().parents[3]
ENTRYPOINT_SH = WORKSPACE_DIR / "prod-setup" / "jenkins" / "entrypoint.sh"

def run_scenario(uid, socket_gid, existing_groups, readonly_fs=False, stat_fails=False):
    """
    Runs entrypoint.sh in a mocked environment.
    """
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_path = Path(temp_dir)
        mock_bin_dir = temp_path / "bin"
        mock_bin_dir.mkdir()
        
        # Create mock id command
        id_mock = mock_bin_dir / "id"
        id_mock.write_text(f"#!/bin/sh\nif [ \"$1\" = \"-u\" ]; then echo {uid}; else echo uid={uid}; fi\n")
        id_mock.chmod(0o755)
        
        # Create mock stat command
        stat_mock = mock_bin_dir / "stat"
        if stat_fails:
            stat_mock.write_text("#!/bin/sh\nexit 1\n")
        else:
            stat_mock.write_text(f"#!/bin/sh\nif [ \"$1\" = \"-c\" ]; then echo {socket_gid}; fi\n")
        stat_mock.chmod(0o755)
        
        # Create mock getent command
        getent_mock = mock_bin_dir / "getent"
        getent_content = "#!/bin/sh\n"
        for name, gid in existing_groups.items():
            getent_content += f"if [ \"$2\" = \"{name}\" ] || [ \"$2\" = \"{gid}\" ]; then echo {name}:x:{gid}:; exit 0; fi\n"
        getent_content += "exit 1\n"
        getent_mock.write_text(getent_content)
        getent_mock.chmod(0o755)
        
        # Create mock groupadd command
        groupadd_mock = mock_bin_dir / "groupadd"
        if readonly_fs:
            groupadd_mock.write_text("#!/bin/sh\necho 'groupadd: cannot lock /etc/group; try again later.' >&2\nexit 10\n")
        else:
            groupadd_mock.write_text("#!/bin/sh\necho \"[MOCK] groupadd $*\"\n")
        groupadd_mock.chmod(0o755)
        
        # Create mock usermod command
        usermod_mock = mock_bin_dir / "usermod"
        if readonly_fs:
            usermod_mock.write_text("#!/bin/sh\necho 'usermod: cannot lock /etc/passwd; try again later.' >&2\nexit 10\n")
        else:
            usermod_mock.write_text("#!/bin/sh\necho \"[MOCK] usermod $*\"\n")
        usermod_mock.chmod(0o755)
        
        # Create mock gosu command
        gosu_mock = mock_bin_dir / "gosu"
        gosu_mock.write_text("#!/bin/sh\necho \"[MOCK] gosu $*\"\n")
        gosu_mock.chmod(0o755)
        
        # Create mock tini command
        tini_mock = mock_bin_dir / "tini"
        tini_mock.write_text("#!/bin/sh\necho \"[MOCK] tini $*\"\n")
        tini_mock.chmod(0o755)
        
        # Set up a fake /var/run/docker.sock if socket_gid is not None
        env = os.environ.copy()
        env["PATH"] = f"{mock_bin_dir}{os.pathsep}{env['PATH']}"
        
        # On Windows, we need to run bash to execute entrypoint.sh
        # If bash is not found, we cannot run the test
        bash_executable = shutil.which("bash")
        if not bash_executable:
            print("Bash not found. Skipping execution test.")
            return None, None
            
        # Run entrypoint.sh
        try:
            # We mock the -e file test inside entrypoint.sh by creating a file
            # However, entrypoint.sh hardcodes DOCKER_SOCKET="/var/run/docker.sock"
            # Since we cannot write to /var/run/docker.sock on Windows without admin / it's a system path,
            # we need to modify the socket path in a copy of entrypoint.sh or run it.
            # Let's create a temporary copy of entrypoint.sh where we replace the socket path
            entrypoint_content = ENTRYPOINT_SH.read_text(encoding="utf-8")
            
            fake_socket = temp_path / "docker.sock"
            if socket_gid is not None:
                fake_socket.touch()
                
            entrypoint_content = entrypoint_content.replace(
                'DOCKER_SOCKET="/var/run/docker.sock"',
                f'DOCKER_SOCKET="{fake_socket.as_posix()}"'
            )
            
            # We also replace /sbin/tini and /usr/local/bin/jenkins.sh with mocks if needed
            # For testing, we mock them to run from PATH
            entrypoint_content = entrypoint_content.replace('/sbin/tini', 'tini')
            entrypoint_content = entrypoint_content.replace('/usr/local/bin/jenkins.sh', 'echo jenkins-started')
            
            temp_entrypoint = temp_path / "entrypoint.sh"
            temp_entrypoint.write_text(entrypoint_content, encoding="utf-8")
            temp_entrypoint.chmod(0o755)
            
            result = subprocess.run(
                [bash_executable, temp_entrypoint.as_posix(), "arg1", "arg2"],
                env=env,
                capture_output=True,
                text=True
            )
            return result.returncode, result.stdout + result.stderr
        except Exception as e:
            return -1, str(e)

def main():
    print("=== Running Entrypoint Script Test Suite ===")
    
    # 1. Test running as non-root (UID 1000)
    print("\nTest 1: Non-root execution")
    code, output = run_scenario(uid=1000, socket_gid=None, existing_groups={})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 2. Test running as root (UID 0) with no socket
    print("\nTest 2: Root execution, no socket")
    code, output = run_scenario(uid=0, socket_gid=None, existing_groups={})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 3. Test running as root, socket GID < 100 (privileged GID 42)
    print("\nTest 3: Root execution, privileged GID < 100")
    code, output = run_scenario(uid=0, socket_gid=42, existing_groups={"shadow": 42})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 4. Test running as root, socket GID >= 100, no collision (GID 999 -> docker exists)
    print("\nTest 4: Root execution, docker GID 999 (expected docker group)")
    code, output = run_scenario(uid=0, socket_gid=999, existing_groups={"docker": 999})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 5. Test running as root, socket GID >= 100, collision with system group (GID 101 -> systemd-journal)
    print("\nTest 5: Root execution, GID collision with system group systemd-journal (GID 101)")
    code, output = run_scenario(uid=0, socket_gid=101, existing_groups={"systemd-journal": 101})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 6. Test running as root, socket GID >= 100, non-colliding (GID 1005)
    print("\nTest 6: Root execution, new GID (no collision)")
    code, output = run_scenario(uid=0, socket_gid=1005, existing_groups={})
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 7. Test running as root, stat command fails
    print("\nTest 7: Root execution, stat command fails")
    code, output = run_scenario(uid=0, socket_gid=999, existing_groups={}, stat_fails=True)
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")
    
    # 8. Test running as root, read-only filesystem (groupadd fails)
    print("\nTest 8: Root execution, read-only filesystem (groupadd fails)")
    code, output = run_scenario(uid=0, socket_gid=1005, existing_groups={}, readonly_fs=True)
    print(f"Exit code: {code}")
    print(f"Output:\n{output}")

if __name__ == "__main__":
    main()
