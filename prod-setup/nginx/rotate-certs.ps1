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

# Prevent MSYS path conversion on Windows/Git Bash/OpenSSL
$env:MSYS_NO_PATHCONV = 1

# Helper function to restrict key file permissions on Windows
function Restrict-KeyPermissions ($file) {
    if (Test-Path $file) {
        $acl = Get-Acl $file
        $acl.SetAccessRuleProtection($true, $false) # Protect ACL, disable inheritance
        $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($currentUser, "FullControl", "Allow")
        $acl.AddAccessRule($accessRule)
        Set-Acl $file $acl
    }
}

Write-Host "Generating new self-signed certificate and private key..."
& openssl req -x509 -nodes -days 365 -newkey rsa:2048 `
  -keyout $KeyFileNew `
  -out $CertFileNew `
  -subj $subj `
  -addext $san

# Set secure permissions on temporary key immediately
Restrict-KeyPermissions $KeyFileNew

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
        
        # Restrict backup directory permissions
        if (Test-Path $BackupDir) {
            $acl = Get-Acl $BackupDir
            $acl.SetAccessRuleProtection($true, $false)
            $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
            $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($currentUser, "FullControl", "Allow")
            $acl.AddAccessRule($accessRule)
            Set-Acl $BackupDir $acl
        }
        
        if (Test-Path $CertFile) {
            Move-Item -Path $CertFile -Destination (Join-Path $BackupDir "cic.local.crt.$Timestamp") -Force
            Write-Host "Archived active certificate to: $BackupDir\cic.local.crt.$Timestamp"
        }
        if (Test-Path $KeyFile) {
            $backupKeyPath = Join-Path $BackupDir "cic.local.key.$Timestamp"
            Move-Item -Path $KeyFile -Destination $backupKeyPath -Force
            Restrict-KeyPermissions $backupKeyPath
            Write-Host "Archived active private key to: $BackupDir\cic.local.key.$Timestamp"
        }
    }
    
    # Make new certificates active
    Move-Item -Path $CertFileNew -Destination $CertFile -Force
    Move-Item -Path $KeyFileNew -Destination $KeyFile -Force
    Restrict-KeyPermissions $KeyFile
    Write-Host "New certificates are now active."
    
    # Reload Nginx if Docker is available
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        $containerRunning = docker inspect -f '{{.State.Running}}' cic-nginx 2>$null
        if ($containerRunning -eq "true") {
            Write-Host "Reloading Nginx service in 'cic-nginx' container..."
            & docker exec cic-nginx nginx -s reload
            if ($LASTEXITCODE -ne 0) {
                Write-Error "[-] Nginx reload failed (Exit Code: $LASTEXITCODE). Initiating rollback..."
                
                # Rollback logic: Restore backup files if Nginx reload fails
                if ($Timestamp) {
                    $backupCert = Join-Path $BackupDir "cic.local.crt.$Timestamp"
                    $backupKey = Join-Path $BackupDir "cic.local.key.$Timestamp"
                    
                    if (Test-Path $backupCert) {
                        Move-Item -Path $backupCert -Destination $CertFile -Force
                        Write-Host "[+] Restored backup certificate."
                    }
                    if (Test-Path $backupKey) {
                        Move-Item -Path $backupKey -Destination $KeyFile -Force
                        Restrict-KeyPermissions $KeyFile
                        Write-Host "[+] Restored backup private key."
                    }
                    
                    # Try reload Nginx again with restored certs to restore service
                    & docker exec cic-nginx nginx -s reload | Out-Null
                }
                Exit 1
            }
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
