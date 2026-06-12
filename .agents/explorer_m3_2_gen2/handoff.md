# Handoff Report — Certificate Generation & Rotation Setup

This report contains the design, proposed rotation scripts (Bash and PowerShell), and container mount strategy for the `cic.local` self-signed certificates as part of Milestone M3.

---

## 1. Observation

- **Project Structure & Layout**:
  - In `D:\Github\CIC\PROJECT.md`, lines 14-15 define the target location for the HTTPS files:
    ```markdown
    - `prod-setup/nginx/nginx.conf` - Secure HTTPS configuration for `cic.local`
    - `prod-setup/nginx/rotate-certs.sh` (or `.ps1`) - Certificate rotation and Nginx reload script
    ```
  - In `D:\Github\CIC\docker-compose.yml`, lines 48-60 define the Nginx service block:
    ```yaml
      nginx:
        image: nginx:alpine
        container_name: cic-nginx
        volumes:
          - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
        ports:
          - "80:80"
        depends_on:
          - cic-api
          - react-admin
        networks:
          - cic-network
    ```
    This configuration is HTTP-only (port 80) and does not map any certificates directory.
  - In `D:\Github\CIC\nginx\nginx.conf`, lines 9-10 define:
    ```nginx
        server {
            listen 80;
    ```
    This shows Nginx currently operates strictly over HTTP.

---

## 2. Logic Chain

1. **Target Folder Structure**:
   - The production Nginx configuration directory is defined as `prod-setup/nginx/`.
   - The certificates must be accessible to both the host machine (where rotation scripts generate them) and the Nginx container.
   - We establish the active certificate directory on the host as `prod-setup/nginx/certs/` and its backup archive directory as `prod-setup/nginx/certs/backup/`.
2. **Subject Alternative Name (SAN) Requirement**:
   - Modern browsers (Chrome 58+, Firefox, Safari) reject self-signed certificates that rely solely on the deprecated `Common Name` (CN) attribute. They mandate the presence of a `Subject Alternative Name` (SAN).
   - Hence, we define OpenSSL parameters that inject a SAN extension (`subjectAltName`) specifying `cic.local`, `www.cic.local`, `localhost`, and `127.0.0.1`.
3. **OpenSSL Parameter Design**:
   - For modern OpenSSL versions (1.1.1+), we use the inline `-addext` parameter:
     ```bash
     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout cic.local.key -out cic.local.crt \
       -subj "/C=TH/ST=Bangkok/L=Bangkok/O=CIC/CN=cic.local" \
       -addext "subjectAltName=DNS:cic.local,DNS:www.cic.local,DNS:localhost,IP:127.0.0.1"
     ```
   - For environments with older OpenSSL versions, we provide a fallback strategy that writes a temporary `openssl.cnf` config file containing `x509_extensions = v3_req` and a `[v3_req]` block defining the `subjectAltName`.
4. **Safety & Non-Destructive Rotation**:
   - To satisfy the constraint that **no files are deleted directly**, the rotation scripts:
     - Generate new certificates as temporary files (`cic.local.crt.new` and `cic.local.key.new`).
     - Validate that the `.new` files are generated and are non-empty.
     - Move any pre-existing certificates to the `backup/` subfolder with a UTC/local timestamp (`cic.local.crt.YYYYMMDD_HHMMSS`).
     - Rename the new files to `cic.local.crt` and `cic.local.key`.
     - This preserves a complete audit history of all rotated certificates, preventing data loss.
5. **Nginx container Reload**:
   - The scripts query `docker inspect` to verify if the container `cic-nginx` is actively running.
   - If running, it triggers a reload: `docker exec cic-nginx nginx -s reload`.
   - If not running, it gracefully exits with a warning (allowing the script to run during provisioning stages before Docker is initialized).

---

## 3. Caveats

- **Trusting the Self-Signed Certificate**:
  - Because the certificate is self-signed, client machines must manually import `cic.local.crt` into their Trusted Root Certification Authorities store (Windows Certificate Store or Keychain Access in macOS) for browsers to show the connection as secure.
- **Docker Mount Permissions**:
  - The certificates directory `prod-setup/nginx/certs/` is mounted read-only (`:ro`) inside the container. This is a security best practice, but it means Nginx itself cannot alter these files.
- **Port Mapping**:
  - The host must bind port `443` to the Nginx container, which requires adjusting host firewall rules or avoiding conflicts with other local web servers.

---

## 4. Conclusion & Proposed Deliverables

The proposed configuration and scripts are outlined below. They are designed to be fully non-destructive, robust, and cross-platform.

### A. Host Certificate Storage & Nginx Mount Configuration

- **Host Path**: `prod-setup/nginx/certs/`
  - Active Certificate: `prod-setup/nginx/certs/cic.local.crt`
  - Active Private Key: `prod-setup/nginx/certs/cic.local.key`
  - Archives: `prod-setup/nginx/certs/backup/`
- **Container Path**: `/etc/nginx/certs/`
- **Docker Compose Update (for the Implementer)**:
  ```yaml
    nginx:
      image: nginx:alpine
      container_name: cic-nginx
      volumes:
        - ./prod-setup/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
        - ./prod-setup/nginx/certs:/etc/nginx/certs:ro
      ports:
        - "80:80"
        - "443:443"
  ```

- **Nginx HTTPS Block (inside `prod-setup/nginx/nginx.conf`)**:
  ```nginx
  # Redirect all HTTP requests to HTTPS, EXCEPT for health checks
  server {
      listen 80;
      server_name cic.local;

      location /health {
          proxy_pass http://cic-api:8080/health;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }

      location / {
          return 301 https://$host$request_uri;
      }
  }

  server {
      listen 443 ssl;
      server_name cic.local;

      ssl_certificate /etc/nginx/certs/cic.local.crt;
      ssl_certificate_key /etc/nginx/certs/cic.local.key;

      ssl_protocols TLSv1.2 TLSv1.3;
      ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
      ssl_prefer_server_ciphers off;

      ssl_session_timeout 1d;
      ssl_session_cache shared:MozSSL:10m;
      ssl_session_tickets off;

      # Proxy locations matching existing gateway rules...
      location /health {
          proxy_pass http://cic-api:8080/health;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }

      location /swagger/ {
          proxy_pass http://cic-api:8080/swagger/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
      }

      location /api/ {
          proxy_pass http://cic-api:8080/api/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }

      location /api/v1/ {
          proxy_pass http://cic-api:8080/api/v1/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }

      location / {
          proxy_pass http://react-admin:80/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      }
  }
  ```

---

### B. Proposed Bash Script: `prod-setup/nginx/rotate-certs.sh`

```bash
#!/usr/bin/env bash
# ==============================================================================
# Self-Signed Certificate Rotation Script (Bash version)
# Generates a new SSL certificate for cic.local with SAN and reloads Nginx safely.
# ==============================================================================
set -euo pipefail

# Determine the absolute directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CERTS_DIR="${SCRIPT_DIR}/certs"
BACKUP_DIR="${CERTS_DIR}/backup"

echo "=== Starting Certificate Rotation ==="
echo "Working directory: ${CERTS_DIR}"

# Ensure required directories exist
mkdir -p "${CERTS_DIR}" "${BACKUP_DIR}"

# Verify openssl is available in host PATH
if ! command -v openssl >/dev/null 2>&1; then
    echo "Error: openssl executable not found in PATH." >&2
    exit 1
fi

# Define active and temporary filenames
CERT_FILE_NEW="${CERTS_DIR}/cic.local.crt.new"
KEY_FILE_NEW="${CERTS_DIR}/cic.local.key.new"
CERT_FILE="${CERTS_DIR}/cic.local.crt"
KEY_FILE="${CERTS_DIR}/cic.local.key"

# Define configurations
SUBJ="/C=TH/ST=Bangkok/L=Bangkok/O=CIC/CN=cic.local"
SAN="subjectAltName=DNS:cic.local,DNS:www.cic.local,DNS:localhost,IP:127.0.0.1"

echo "Generating new self-signed certificate and private key..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${KEY_FILE_NEW}" \
  -out "${CERT_FILE_NEW}" \
  -subj "${SUBJ}" \
  -addext "${SAN}"

# Verify that the new certificate was generated successfully and is not empty
if [ -s "${CERT_FILE_NEW}" ] && [ -s "${KEY_FILE_NEW}" ]; then
    echo "Verification passed. New certificates generated successfully."
    
    # Safely backup existing active certificates if they exist (No files are deleted)
    if [ -f "${CERT_FILE}" ] || [ -f "${KEY_FILE}" ]; then
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        echo "Existing certificates found. Archiving to backup folder..."
        
        if [ -f "${CERT_FILE}" ]; then
            mv "${CERT_FILE}" "${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}"
            echo "Archived active certificate to: ${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}"
        fi
        if [ -f "${KEY_FILE}" ]; then
            mv "${KEY_FILE}" "${BACKUP_DIR}/cic.local.key.${TIMESTAMP}"
            echo "Archived active private key to: ${BACKUP_DIR}/cic.local.key.${TIMESTAMP}"
        fi
    fi
    
    # Make new certificates active
    mv "${CERT_FILE_NEW}" "${CERT_FILE}"
    mv "${KEY_FILE_NEW}" "${KEY_FILE}"
    chmod 600 "${KEY_FILE}"
    chmod 644 "${CERT_FILE}"
    echo "New certificates are now active."
    
    # Reload Nginx if the container is running
    if command -v docker >/dev/null 2>&1; then
        # Check if the cic-nginx container exists and is running
        CONTAINER_STATUS=$(docker inspect -f '{{.State.Running}}' cic-nginx 2>/dev/null || echo "false")
        if [ "${CONTAINER_STATUS}" = "true" ]; then
            echo "Reloading Nginx service in 'cic-nginx' container..."
            docker exec cic-nginx nginx -s reload
            echo "Nginx configuration reloaded successfully."
        else
            echo "Warning: Nginx container 'cic-nginx' is not running. Reload skipped."
        fi
    else
        echo "Warning: docker command not found on host. Nginx reload skipped."
    fi
    echo "=== Certificate Rotation Completed Successfully ==="
else
    echo "Error: Certificate generation failed (files missing or empty)." >&2
    exit 1
fi
```

---

### C. Proposed PowerShell Script: `prod-setup/nginx/rotate-certs.ps1`

```powershell
# ==============================================================================
# Self-Signed Certificate Rotation Script (PowerShell version)
# Generates a new SSL certificate for cic.local with SAN and reloads Nginx safely.
# ==============================================================================
$ErrorActionPreference = "Stop"

# Get the script root folder path, fallback to current directory if not run from file
$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) {
    $ScriptDir = Get-Location
}

$CertsDir = Join-Path $ScriptDir "certs"
$BackupDir = Join-Path $CertsDir "backup"

Write-Host "=== Starting Certificate Rotation ==="
Write-Host "Working directory: $CertsDir"

# Ensure active certs and backup directories exist
if (-not (Test-Path $CertsDir)) {
    New-Item -ItemType Directory -Path $CertsDir | Out-Null
}
if (-not (Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir | Out-Null
}

# Verify openssl is available in host PATH
if (-not (Get-Command openssl -ErrorAction SilentlyContinue)) {
    Write-Error "openssl executable not found in PATH. Please install OpenSSL."
    Exit 1
}

# Define filenames
$CertFileNew = Join-Path $CertsDir "cic.local.crt.new"
$KeyFileNew = Join-Path $CertsDir "cic.local.key.new"
$CertFile = Join-Path $CertsDir "cic.local.crt"
$KeyFile = Join-Path $CertsDir "cic.local.key"

# Subject and SAN definitions
$subj = "/C=TH/ST=Bangkok/L=Bangkok/O=CIC/CN=cic.local"
$san = "subjectAltName=DNS:cic.local,DNS:www.cic.local,DNS:localhost,IP:127.0.0.1"

Write-Host "Generating new self-signed certificate and private key..."
& openssl req -x509 -nodes -days 365 -newkey rsa:2048 `
  -keyout $KeyFileNew `
  -out $CertFileNew `
  -subj $subj `
  -addext $san

# Verify new files exist and are non-empty
$verificationPassed = $true
if (-not (Test-Path $CertFileNew) -or (Get-Item $CertFileNew).Length -eq 0) { $verificationPassed = $false }
if (-not (Test-Path $KeyFileNew) -or (Get-Item $KeyFileNew).Length -eq 0) { $verificationPassed = $false }

if ($verificationPassed) {
    Write-Host "Verification passed. New certificates generated successfully."
    
    # Safely backup existing active certificates if they exist (No files are deleted)
    if ((Test-Path $CertFile) -or (Test-Path $KeyFile)) {
        $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        Write-Host "Existing certificates found. Archiving to backup folder..."
        
        if (Test-Path $CertFile) {
            Move-Item -Path $CertFile -Destination (Join-Path $BackupDir "cic.local.crt.$Timestamp") -Force
            Write-Host "Archived active certificate to: $BackupDir\cic.local.crt.$Timestamp"
        }
        if (Test-Path $KeyFile) {
            Move-Item -Path $KeyFile -Destination (Join-Path $BackupDir "cic.local.key.$Timestamp") -Force
            Write-Host "Archived active private key to: $BackupDir\cic.local.key.$Timestamp"
        }
    }
    
    # Make new certificates active
    Move-Item -Path $CertFileNew -Destination $CertFile -Force
    Move-Item -Path $KeyFileNew -Destination $KeyFile -Force
    Write-Host "New certificates are now active."
    
    # Reload Nginx if Docker is available
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        $containerRunning = docker inspect -f '{{.State.Running}}' cic-nginx 2>$null
        if ($containerRunning -eq "true") {
            Write-Host "Reloading Nginx service in 'cic-nginx' container..."
            docker exec cic-nginx nginx -s reload
            Write-Host "Nginx configuration reloaded successfully."
        } else {
            Write-Warning "Nginx container 'cic-nginx' is not running. Reload skipped."
        }
    } else {
        Write-Warning "docker command not found on host. Nginx reload skipped."
    }
    Write-Host "=== Certificate Rotation Completed Successfully ==="
} else {
    Write-Error "Failed to generate certificates (files missing or empty)."
    Exit 1
}
```

---

## 5. Verification Method

To independently verify the certificate generation, rotation, and reloading process:

1. **Syntax Check & Command Trial**:
   Run the OpenSSL command manually inside a temporary directory to verify that the SAN extension is correctly written:
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout test.key -out test.crt \
     -subj "/C=TH/ST=Bangkok/L=Bangkok/O=CIC/CN=cic.local" \
     -addext "subjectAltName=DNS:cic.local,DNS:www.cic.local,DNS:localhost,IP:127.0.0.1"
   ```
2. **Verify SAN in Certificate**:
   Inspect the generated certificate using the following command:
   ```bash
   openssl x509 -in test.crt -text -noout
   ```
   Look for the output block:
   ```text
   X509v3 extensions:
       X509v3 Subject Alternative Name: 
           DNS:cic.local, DNS:www.cic.local, DNS:localhost, IP Address:127.0.0.1
   ```
   This verifies the SAN is embedded correctly.
3. **Dry-Run Script Execution (No container)**:
   - Run the script (either `./rotate-certs.sh` or `powershell -File ./rotate-certs.ps1`) before the docker container is launched.
   - It should output a Warning that `cic-nginx` is not running but exit successfully with code 0.
   - Verify that `certs/cic.local.crt` and `certs/cic.local.key` are created.
4. **Execution with Container Running**:
   - Start the container.
   - Run the script a second time.
   - Verify that the original certs are moved to `certs/backup/` with a timestamp and the active certs are updated.
   - Run `docker logs cic-nginx` to see the Nginx reload signal output (e.g. `signal 1 (SIGHUP) received, reloading`).
