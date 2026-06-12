#!/usr/bin/env bash
# ==============================================================================
# Self-Signed Certificate Rotation Script (Bash version)
# Generates a new SSL certificate for cic.local with SAN and reloads Nginx safely.
# ==============================================================================
set -euo pipefail

# Prevent MSYS path conversion on Windows/Git Bash/OpenSSL
export MSYS_NO_PATHCONV=1

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

# Set secure permissions on temporary key immediately
chmod 600 "${KEY_FILE_NEW}"
chmod 644 "${CERT_FILE_NEW}"

# Verify that the new certificate was generated successfully and is not empty
if [ -s "${CERT_FILE_NEW}" ] && [ -s "${KEY_FILE_NEW}" ]; then
    echo "Verification passed. New certificates generated successfully."
    
    # Safely backup existing active certificates if they exist (No files are deleted)
    if [ -f "${CERT_FILE}" ] || [ -f "${KEY_FILE}" ]; then
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        echo "Existing certificates found. Archiving to backup folder..."
        
        # Restrict backup directory permissions
        chmod 700 "${BACKUP_DIR}"
        
        if [ -f "${CERT_FILE}" ]; then
            mv "${CERT_FILE}" "${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}"
            chmod 644 "${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}"
            echo "Archived active certificate to: ${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}"
        fi
        if [ -f "${KEY_FILE}" ]; then
            mv "${KEY_FILE}" "${BACKUP_DIR}/cic.local.key.${TIMESTAMP}"
            chmod 600 "${BACKUP_DIR}/cic.local.key.${TIMESTAMP}"
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
            if ! docker exec cic-nginx nginx -s reload; then
                echo "[-] Error: Nginx reload failed. Initiating rollback..." >&2
                
                # Rollback logic: Restore backup files if Nginx reload fails
                if [ -n "${TIMESTAMP:-}" ]; then
                    if [ -f "${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}" ]; then
                        mv "${BACKUP_DIR}/cic.local.crt.${TIMESTAMP}" "${CERT_FILE}"
                        chmod 644 "${CERT_FILE}"
                        echo "[+] Restored backup certificate." >&2
                    fi
                    if [ -f "${BACKUP_DIR}/cic.local.key.${TIMESTAMP}" ]; then
                        mv "${BACKUP_DIR}/cic.local.key.${TIMESTAMP}" "${KEY_FILE}"
                        chmod 600 "${KEY_FILE}"
                        echo "[+] Restored backup private key." >&2
                    fi
                    # Reload Nginx again with restored certs to restore service
                    docker exec cic-nginx nginx -s reload || true
                fi
                exit 1
            fi
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
