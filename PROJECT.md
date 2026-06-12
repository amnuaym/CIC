# Project: CIC Production Setup

## Architecture
This project sets up the enterprise production configuration for the Customer Information Center (CIC) application. It contains three main infrastructure setups:
1. **Jenkins CI/CD**: A Docker setup to run Jenkins and a Jenkinsfile to build Go API and React Admin production assets.
2. **GCP Deployment**: IaC/deployment manifests (Terraform/Kubernetes) and a deployment script that authenticates using `gcp-key.json`.
3. **SSL/TLS & Key Rotation**: An Nginx gateway configuration for local domain `cic.local` on HTTPS (port 443) and an automated mock certificate rotation script.

## Code Layout
- `prod-setup/jenkins/Dockerfile` - Docker setup for Jenkins
- `prod-setup/jenkins/Jenkinsfile` - Jenkins pipeline definition
- `prod-setup/gcp/` - Directory for GCP Terraform or Kubernetes manifests
- `prod-setup/gcp/deploy.sh` (or `deploy.ps1`) - Deploy script using `gcp-key.json`
- `prod-setup/nginx/nginx.conf` - Secure HTTPS configuration for `cic.local`
- `prod-setup/nginx/rotate-certs.sh` (or `.ps1`) - Certificate rotation and Nginx reload script

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|---|---|---|---|
| M1 | Jenkins CI/CD Setup | Prepare Docker configuration for Jenkins container and a Jenkinsfile to compile the Go API and React Admin frontend. | none | DONE |
| M2 | GCP Deployment Setup | Create Terraform / Kubernetes manifests under `prod-setup/gcp/` and a shell/powershell deployment script that uses `gcp-key.json` for GCP auth and deployment. | none | DONE |
| M3 | SSL/TLS & Key Rotation | Configure Nginx gateway under `prod-setup/nginx/` for `cic.local` HTTPS port 443, and an automated certificate rotation script. | none | DONE |
| M4 | Integration & Verification | Run verification checks and Forensic Audit. | M1, M2, M3 | DONE |

## Interface Contracts
- **Jenkins ↔ Go API & React Admin**: The Jenkinsfile must build the binaries/assets successfully.
- **Deployment Script ↔ GCP**: The script must authenticate with `gcp-key.json` (mock or real) and run deployment commands.
- **Nginx ↔ Go & React**: Nginx must proxy requests from `cic.local:443` to `cic-api` (Go) and `react-admin` (React Admin).
- **Rotation Script ↔ Nginx**: The rotation script must regenerate self-signed certificates and force reload Nginx configuration.
