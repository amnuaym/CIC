# verify_m1.ps1
# This script automates the dynamic testing of the Jenkins Docker setup for Milestone 1.
# It builds the image, runs containers in different privilege modes, and asserts correctness/security.

$ErrorActionPreference = "Stop"

$IMAGE_NAME = "jenkins-m1-challenge-test"
$CONTAINER_NAME = "jenkins-m1-root-run"
$NONROOT_CONTAINER_NAME = "jenkins-m1-nonroot-run"
$JENKINS_DIR = "D:\Github\cic\prod-setup\jenkins"

Write-Host "[*] Starting Milestone 1 Validation Suite" -ForegroundColor Cyan

# 1. Build the Jenkins Docker image
Write-Host "[*] Building local Jenkins image..." -ForegroundColor Gray
docker build -t $IMAGE_NAME $JENKINS_DIR

# 2. Test Scenario 1: Running as Root (Simulating docker-compose.yml configuration)
Write-Host "[*] Scenario 1: Running container as ROOT..." -ForegroundColor Gray
# We run the container in the background
$containerId = docker run -d --name $CONTAINER_NAME --user root -v /var/run/docker.sock:/var/run/docker.sock $IMAGE_NAME
Start-Sleep -Seconds 5

# Check the running user of the container process
Write-Host "[*] Checking user and group identities inside the container..." -ForegroundColor Gray
$runningUser = (docker exec $CONTAINER_NAME whoami).Trim()
$runningId = (docker exec $CONTAINER_NAME id).Trim()

Write-Host "[+] Running User: $runningUser" -ForegroundColor Yellow
Write-Host "[+] Running ID info: $runningId" -ForegroundColor Yellow

# Verify if privileges were dropped
if ($runningUser -eq "root") {
    Write-Host "[FAIL] VULNERABILITY CONFIRMED: Jenkins is running as ROOT inside the container!" -ForegroundColor Red
    Write-Host "       The entrypoint failed to drop privileges to the 'jenkins' user." -ForegroundColor Red
} else {
    Write-Host "[PASS] Jenkins is running as non-root user: $runningUser" -ForegroundColor Green
}

# Clean up Scenario 1
Write-Host "[*] Cleaning up Scenario 1 container..." -ForegroundColor Gray
docker stop $CONTAINER_NAME | Out-Null
docker rm $CONTAINER_NAME | Out-Null


# 3. Test Scenario 2: Running as Default User (USER jenkins)
Write-Host "[*] Scenario 2: Running container as default user (non-root)..." -ForegroundColor Gray
$nonrootContainerId = docker run -d --name $NONROOT_CONTAINER_NAME -v /var/run/docker.sock:/var/run/docker.sock $IMAGE_NAME
Start-Sleep -Seconds 5

# Inspect container status and logs
$containerStatus = (docker inspect -f '{{.State.Status}}' $NONROOT_CONTAINER_NAME).Trim()
$containerExitCode = (docker inspect -f '{{.State.ExitCode}}' $NONROOT_CONTAINER_NAME).Trim()
$logs = docker logs $NONROOT_CONTAINER_NAME 2>&1

Write-Host "[+] Container Status: $containerStatus (Exit Code: $containerExitCode)" -ForegroundColor Yellow

if ($containerStatus -eq "exited" -or $containerExitCode -ne "0") {
    Write-Host "[FAIL] CRASH PATH CONFIRMED: Container crashed during non-root startup!" -ForegroundColor Red
    Write-Host "       Logs show:" -ForegroundColor Gray
    Write-Host "$logs" -ForegroundColor DarkRed
} else {
    Write-Host "[PASS] Container started successfully as non-root." -ForegroundColor Green
    docker stop $NONROOT_CONTAINER_NAME | Out-Null
}

# Clean up Scenario 2
Write-Host "[*] Cleaning up Scenario 2 container..." -ForegroundColor Gray
docker rm $NONROOT_CONTAINER_NAME | Out-Null

# Clean up Image
Write-Host "[*] Removing test docker image..." -ForegroundColor Gray
docker rmi $IMAGE_NAME | Out-Null

Write-Host "[*] Validation Suite Completed." -ForegroundColor Cyan
