# Project: CIC Production Infrastructure (Phase 2 - Resumed)

## Architecture
This phase enhances the local Jenkins containerized environment with Docker-outside-of-Docker (DooD) permissions fixes, configures an isolated private GCE VM instance on GCP via Terraform (no public IP, custom SA, secured behind IAP), and integrates GKE deployment into the Jenkins pipeline using the VM metadata server.

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|---|---|---|---|
| M1 | Local Jenkins DooD Setup & Entrypoint Fixes | Fix tini path to `/sbin/tini`, handle empty DOCKER_GID in entrypoint.sh, and configure optional service account key mount in docker-compose.yml. | none | DONE |
| M2 | GCP Private VM Config & Terraform Consistency | Verify Terraform configuration (remove unused service account resource, ensure existing email is used, check resource policy for daily start/stop). | none | DONE |
| M3 | GKE Pipeline & Deploy Integration | Update deploy.sh (use correct GCP_PROJECT, REGION, gcp-key.json, and dry-run=client flag), and update root Jenkinsfile to use correct region and SA. | M1, M2 | DONE |
| M4 | Finalization & Verification | Create README.md summarizing setup, run terraform validate, and pass reviews, challenger tests, and Forensic Audit. | M1, M2, M3 | DONE |

## Interface Contracts
- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and drop privileges to jenkins using `gosu`. Fix tini path to `/sbin/tini` and handle empty GID safely.
- **GCE Private VM**: Terraform configuration must ensure no public IP, configure custom VPC/subnet, Cloud Router & NAT for egress, and configure a firewall rule allowing only TCP ports 22 and 8080 from the IAP range (35.235.240.0/20). Verify instance scheduling policy is correct for start/stop.
- **GKE Deploy Stage**: Jenkinsfile stage gated to branch 'main' running the deploy.sh script which automatically authenticates using VM metadata server if gcp-key.json is missing, and performs base64 secrets substitution before applying. Include dry-run flag.
