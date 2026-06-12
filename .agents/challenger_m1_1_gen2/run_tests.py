import subprocess
import sys
import os

def run_cmd(cmd, check=True):
    print(f"Running: {cmd}")
    res = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if check and res.returncode != 0:
        print(f"Error executing command: {cmd}")
        print(f"STDOUT:\n{res.stdout}")
        print(f"STDERR:\n{res.stderr}")
        raise subprocess.CalledProcessError(res.returncode, cmd, res.stdout, res.stderr)
    return res

def main():
    image_name = "jenkins-challenger"
    container_name = "challenger-test-container"
    workspace_dir = "D:\\Github\\cic"
    
    # 1. Build the Docker image
    print("Building Docker image...")
    run_cmd(f"docker build -t {image_name} -f {workspace_dir}\\prod-setup\\jenkins\\Dockerfile {workspace_dir}\\prod-setup\\jenkins")
    
    # 2. Start container in background (using sleep)
    print("Starting container in background...")
    # Clean any old container first
    subprocess.run(f"docker rm -f {container_name}", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    run_cmd(f"docker run -d --name {container_name} --entrypoint sleep {image_name} 300")
    
    try:
        # 3. Copy test scenarios script into the container
        print("Copying test script to container...")
        run_cmd(f"docker cp {workspace_dir}\\.agents\\challenger_m1_1_gen2\\test_scenarios.sh {container_name}:/test_scenarios.sh")
        
        # 4. Make test script executable
        print("Making test script executable...")
        run_cmd(f"docker exec -u root {container_name} chmod +x /test_scenarios.sh")
        
        # 5. Run the test scenarios
        print("Executing test scenarios inside container...")
        res = run_cmd(f"docker exec -u root {container_name} /test_scenarios.sh", check=False)
        
        print("\n=== TEST RESULTS ===")
        print(res.stdout)
        if res.stderr:
            print("=== STDERR ===")
            print(res.stderr)
            
    finally:
        # 6. Clean up
        print("Cleaning up container...")
        subprocess.run(f"docker rm -f {container_name}", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

if __name__ == "__main__":
    main()
