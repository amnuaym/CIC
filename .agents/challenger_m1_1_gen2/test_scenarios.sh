#!/usr/bin/env bash
# Test script to run inside the container to test /entrypoint.sh

set -e

echo "=== System Information ==="
echo "tini path check:"
ls -la /usr/bin/tini || echo "No /usr/bin/tini"
ls -la /sbin/tini || echo "No /sbin/tini"
echo "gosu path check:"
which gosu || echo "No gosu"

# Create a mock tini and jenkins.sh to capture executions
mkdir -p /mock
cat << 'EOF' > /mock/tini
#!/usr/bin/env bash
echo "MOCK_TINI: $@"
# Shift -- if present
if [ "$1" = "--" ]; then
    shift
fi
exec "$@"
EOF
chmod +x /mock/tini

cat << 'EOF' > /mock/jenkins.sh
#!/usr/bin/env bash
echo "MOCK_JENKINS: running as user=$(whoami) (uid=$(id -u)), groups=$(id -G)"
EOF
chmod +x /mock/jenkins.sh

# Backup and symlink to intercept entrypoint.sh calls
if [ -e /usr/bin/tini ]; then
    mv /usr/bin/tini /usr/bin/tini.bak
fi
ln -sf /mock/tini /usr/bin/tini

if [ -e /usr/local/bin/jenkins.sh ]; then
    mv /usr/local/bin/jenkins.sh /usr/local/bin/jenkins.sh.bak
fi
ln -sf /mock/jenkins.sh /usr/local/bin/jenkins.sh

# Let's also check /sbin/tini
if [ -e /sbin/tini ]; then
    mv /sbin/tini /sbin/tini.bak
fi
ln -sf /mock/tini /sbin/tini

# Function to run a test scenario
run_scenario() {
    local scenario_name="$1"
    local run_as_root="$2"
    local socket_gid="$3" # set to "" if no socket
    
    echo ""
    echo "========================================="
    echo "Scenario: $scenario_name"
    echo "========================================="
    
    # Reset socket file
    rm -f /var/run/docker.sock
    if [ -n "$socket_gid" ]; then
        touch /var/run/docker.sock
        chown :"$socket_gid" /var/run/docker.sock
    fi
    
    # Run entrypoint
    if [ "$run_as_root" = "true" ]; then
        # Run as root
        /entrypoint.sh test-arg1 test-arg2
    else
        # Run as non-root (jenkins user, uid 1000)
        su -s /bin/bash jenkins -c "/entrypoint.sh test-arg1 test-arg2"
    fi
}

# Scenario 1: Root, no socket
run_scenario "Root user, no docker socket" "true" ""

# Scenario 2: Root, socket GID 999 (docker group in Dockerfile)
run_scenario "Root user, socket GID 999 (existing group)" "true" "999"

# Scenario 3: Root, socket GID 101 (systemd-journal, collision)
# Let's make sure group with GID 101 exists in our test environment
if ! getent group 101 >/dev/null; then
    groupadd -g 101 systemd-journal || true
fi
run_scenario "Root user, socket GID 101 (collision with systemd-journal)" "true" "101"

# Scenario 4: Root, socket GID 4 (privileged system GID < 100)
# GID 4 is usually adm on Debian
run_scenario "Root user, socket GID 4 (privileged GID < 100)" "true" "4"

# Scenario 5: Non-root user (jenkins, UID 1000)
run_scenario "Non-root user (jenkins), socket GID 999" "false" "999"

# Clean up
rm -f /usr/bin/tini
if [ -e /usr/bin/tini.bak ]; then
    mv /usr/bin/tini.bak /usr/bin/tini
fi
rm -f /usr/local/bin/jenkins.sh
if [ -e /usr/local/bin/jenkins.sh.bak ]; then
    mv /usr/local/bin/jenkins.sh.bak /usr/local/bin/jenkins.sh
fi
rm -f /sbin/tini
if [ -e /sbin/tini.bak ]; then
    mv /sbin/tini.bak /sbin/tini
fi
