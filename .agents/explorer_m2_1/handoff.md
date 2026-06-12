# GCP Terraform Deployment Recommendations for CIC Application

This report provides recommendations and complete Terraform templates for deploying the Customer Information Center (CIC) application (Go API and React Admin) to Google Cloud Platform (GCP).

## 1. Observation
From analyzing the CIC application codebase, we observed:
* **Services**: In `D:\Github\CIC\docker-compose.yml`, the application consists of 4 main services:
  * `cic-api`: Built from `./go`, exposing port 8080. It requires environment variables `DATABASE_URL`, `PORT`, and `JWT_SECRET`.
  * `react-admin`: Built from `./react-admin` (passing `VITE_API_URL` as a build argument), exposing port 80.
  * `nginx`: Acts as a reverse proxy exposing port 80 and routing incoming paths to either `cic-api` or `react-admin`.
  * `keycloak`: A dev Keycloak instance on port 8081 (not currently integrated into the Go API authentication code).
* **Nginx Routing Rules**: In `D:\Github\CIC\nginx\nginx.conf`, we see:
  * `/health` -> `http://cic-api:8080/health`
  * `/swagger/` -> `http://cic-api:8080/swagger/`
  * `/api/` -> `http://cic-api:8080/api/`
  * `/api/v1/` -> `http://cic-api:8080/api/v1/`
  * `/` -> `http://react-admin:80/`
* **Database Connection**: In `D:\Github\CIC\go\internal\database\db.go`, the application attempts to read `DATABASE_URL` for PostgreSQL or falls back to individual variables (`POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_DB`).
* **Authentication**: In `D:\Github\CIC\go\internal\auth\auth.go` and `react-admin/src/authProvider.ts`, the authentication flow is handled directly by the Go API using custom logins and JWT tokens signed with a `JWT_SECRET`.
* **Database Migrations**: In `D:\Github\CIC\go\migrations/`, migrations are defined as raw SQL schema files (`000001_init_schema.up.sql`, etc.), which are not run automatically at API startup.

---

## 2. Logic Chain
1. **Routing & API Gateway**:
   * *Observation*: Local Nginx routes `/api/*` to the Go backend and `/*` to the React frontend.
   * *Inference*: In GCP, running an Nginx container on a VM introduces extra management overhead and single-point-of-failure risks. The native cloud equivalent is an **External HTTP(S) Load Balancer (Application Load Balancer)** configured with path-based routing. It acts as the routing gateway, mapping path paths to Serverless Network Endpoint Groups (NEGs) pointing to the respective Cloud Run services.
2. **Serverless vs. Kubernetes Hosting**:
   * *Observation*: The `cic-api` and `react-admin` containers are stateless.
   * *Inference*: For stateless APIs and web frontends, **Google Cloud Run** is highly recommended over **Google Kubernetes Engine (GKE)**. It offers automatic scaling, scale-to-zero capabilities (cost savings), and zero VM maintenance. GKE Autopilot is a strong alternative only if the system requires continuous heavy computing, complex Kubernetes operator orchestration, or if Keycloak needs to run inside a unified Kubernetes cluster. We will focus our Terraform templates on the primary recommendation (Cloud Run) and provide guidance for GKE.
3. **Database Architecture & Private Networking**:
   * *Observation*: The Go API connects to a PostgreSQL database.
   * *Inference*: In GCP, the recommended managed PostgreSQL service is **Google Cloud SQL for PostgreSQL**. To secure the database, we disable public IP and run it with private IP only. To allow Cloud Run to access this database privately, we need to provision a **Serverless VPC Access Connector** and configure the Cloud Run service's VPC egress settings.
4. **Secret Management**:
   * *Observation*: Secrets like the database password and `JWT_SECRET` are passed via environment variables.
   * *Inference*: For production, credentials and signing secrets must not be stored in plaintext. We recommend using **Google Secret Manager** to store the database password and `JWT_SECRET`. In the Terraform configuration, we reference these secrets and mount them directly as environment variables in the Cloud Run containers.
5. **Database Migrations**:
   * *Observation*: Migrations are SQL files not run automatically by the Go app.
   * *Inference*: To execute migrations against the private database serverless-style, we can define a **Cloud Run Job** in Terraform that runs a migration container (e.g., `migrate/migrate`) over the Serverless VPC Connector. This job can be triggered programmatically in a CI/CD pipeline (e.g., Cloud Build) prior to deploying a new API version.

---

## 3. Caveats
* **Keycloak Deployment**: Although Keycloak is present in `docker-compose.yml`, it is not wired up in the codebase. Therefore, Keycloak is excluded from the primary Terraform configurations. If required, it can be deployed to GKE or Cloud Run (with cloud SQL for storage) and integrated.
* **Build-Time Frontend Configuration**: The React Admin service needs `VITE_API_URL` defined during its build process (`npm run build` in Dockerfile). This means the CI/CD pipeline must know the Load Balancer IP/domain before building and pushing the frontend image. A workaround is injecting config at runtime via a JSON endpoint or template engine in Nginx.

---

## 4. Conclusion
We recommend deploying the CIC application to **Google Cloud Run** using a **GCP Application Load Balancer** for routing, a private **Google Cloud SQL for PostgreSQL** instance, and **Secret Manager** for secrets. 

Below is the recommended Terraform project structure followed by the complete Terraform templates.

### Recommended Project Structure
```text
terraform/
├── providers.tf            # Provider settings & Terraform backend configuration
├── variables.tf            # Variables declarations
├── outputs.tf              # Outputs definition (e.g., Load Balancer IP)
├── main.tf                 # Networking, Secret Manager, Cloud SQL, and compute resources
└── terraform.tfvars.example # Example inputs file
```

### 4.1. `providers.tf`
```hcl
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
```

### 4.2. `variables.tf`
```hcl
variable "project_id" {
  type        = string
  description = "The GCP Project ID where resources will be deployed."
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The GCP region to deploy resources to."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "The deployment environment (e.g., dev, staging, prod)."
}

variable "db_tier" {
  type        = string
  default     = "db-f1-micro"
  description = "The machine type for the Cloud SQL PostgreSQL instance."
}

variable "api_image" {
  type        = string
  description = "The container image URI for the Go API (cic-api)."
}

variable "admin_image" {
  type        = string
  description = "The container image URI for the React Admin (react-admin)."
}

variable "jwt_secret_value" {
  type        = string
  sensitive   = true
  description = "The secret key used for JWT signing and verification in the Go API."
}
```

### 4.3. `main.tf`
```hcl
# -----------------------------------------------------------------------------
# GCP Services APIs Enablement
# -----------------------------------------------------------------------------
resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "run.googleapis.com"
  ])
  service            = each.key
  disable_on_destroy = false
}

# -----------------------------------------------------------------------------
# VPC and Subnets Configuration
# -----------------------------------------------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-cic-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.services]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-cic-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc.id
  region        = var.region
}

# Serverless VPC Access Connector (Allows Cloud Run to reach Private IPs in VPC)
resource "google_vpc_access_connector" "connector" {
  name          = "${var.environment}-vpc-conn"
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.vpc.name
  depends_on    = [google_project_service.services]
}

# -----------------------------------------------------------------------------
# Private Cloud SQL for PostgreSQL Configuration
# -----------------------------------------------------------------------------
# Reserves private IP block within the VPC for services (peering)
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.environment}-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

# Creates the private VPC Peering Connection to Google services (SQL)
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# SQL DB Instance
resource "google_sql_database_instance" "postgres" {
  name             = "${var.environment}-cic-postgres"
  database_version = "POSTGRES_15"
  region           = var.region
  depends_on       = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }
  }
}

resource "google_sql_database" "db" {
  name     = "cic_${var.environment}"
  instance = google_sql_database_instance.postgres.name
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "db_user" {
  name     = "cic_admin"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
}

# -----------------------------------------------------------------------------
# Secret Manager Configuration
# -----------------------------------------------------------------------------
resource "google_secret_manager_secret" "jwt_secret" {
  secret_id  = "${var.environment}-jwt-secret"
  depends_on = [google_project_service.services]
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "jwt_secret_version" {
  secret      = google_secret_manager_secret.jwt_secret.id
  secret_data = var.jwt_secret_value
}

# -----------------------------------------------------------------------------
# Cloud Run Services
# -----------------------------------------------------------------------------
# API Service (Go Backend)
resource "google_cloud_run_v2_service" "api" {
  name     = "${var.environment}-cic-api"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_AND_LOAD_BALANCING"

  template {
    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "ALL_TRAFFIC"
    }

    containers {
      image = var.api_image
      ports {
        container_port = 8080
      }

      env {
        name  = "PORT"
        value = "8080"
      }

      env {
        name  = "DATABASE_URL"
        value = "postgres://${google_sql_user.db_user.name}:${random_password.db_password.result}@${google_sql_database_instance.postgres.private_ip_address}:5432/${google_sql_database.db.name}?sslmode=disable"
      }

      env {
        name = "JWT_SECRET"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.jwt_secret.secret_id
            version = "latest"
          }
        }
      }
    }
  }
}

# Admin Service (React Frontend)
resource "google_cloud_run_v2_service" "admin" {
  name     = "${var.environment}-cic-admin"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_AND_LOAD_BALANCING"

  template {
    containers {
      image = var.admin_image
      ports {
        container_port = 80
      }
    }
  }
}

# -----------------------------------------------------------------------------
# HTTP(S) Load Balancer (Routing Gateway)
# -----------------------------------------------------------------------------
# Serverless Network Endpoint Groups (NEGs)
resource "google_compute_region_network_endpoint_group" "api_neg" {
  name                  = "${var.environment}-api-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.api.name
  }
}

resource "google_compute_region_network_endpoint_group" "admin_neg" {
  name                  = "${var.environment}-admin-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.admin.name
  }
}

# LB Backend Services
resource "google_compute_backend_service" "api_backend" {
  name                  = "${var.environment}-api-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_network_endpoint_group.api_neg.id
  }
}

resource "google_compute_backend_service" "admin_backend" {
  name                  = "${var.environment}-admin-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_network_endpoint_group.admin_neg.id
  }
}

# URL Map for Path-Based Routing (acts like Nginx proxy)
resource "google_compute_url_map" "url_map" {
  name            = "${var.environment}-url-map"
  default_service = google_compute_backend_service.admin_backend.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.admin_backend.id

    path_rule {
      paths   = ["/api", "/api/*", "/health", "/swagger", "/swagger/*"]
      service = google_compute_backend_service.api_backend.id
    }
  }
}

# HTTP proxy and Global Forwarding Rule
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.environment}-http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = "${var.environment}-forwarding-rule"
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

# -----------------------------------------------------------------------------
# IAM Permissions (Allow Load Balancer to invoke Cloud Run)
# -----------------------------------------------------------------------------
resource "google_cloud_run_v2_service_iam_member" "api_invoker" {
  location = google_cloud_run_v2_service.api.location
  name     = google_cloud_run_v2_service.api.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "admin_invoker" {
  location = google_cloud_run_v2_service.admin.location
  name     = google_cloud_run_v2_service.admin.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
```

### 4.4. `outputs.tf`
```hcl
output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.forwarding_rule.ip_address
  description = "The public IP address of the External HTTP Load Balancer."
}

output "database_private_ip" {
  value       = google_sql_database_instance.postgres.private_ip_address
  description = "The private IP address of the Cloud SQL PostgreSQL instance."
}

output "database_name" {
  value       = google_sql_database.db.name
  description = "The name of the database created."
}
```

### 4.5. `terraform.tfvars.example`
```hcl
project_id       = "your-gcp-project-id"
region           = "us-central1"
environment      = "dev"
db_tier          = "db-f1-micro"
api_image        = "gcr.io/your-gcp-project-id/cic-api:latest"
admin_image      = "gcr.io/your-gcp-project-id/cic-admin:latest"
jwt_secret_value = "production-ready-jwt-signing-secret"
```

---

## 5. Verification Method
To verify the setup:
1. **Initialize Terraform**:
   Run `terraform init` to download the GCP provider and set up the state directory.
2. **Verify Configuration Validity**:
   Run `terraform validate` to ensure syntactical correctness of all `.tf` configurations.
3. **Dry-Run Planning**:
   Create a `terraform.tfvars` file, populate it with mock details, and run `terraform plan` to verify resource creation sequence and network peering connections without deploying them.
4. **Endpoint Access**:
   Once applied, access `http://<load_balancer_ip>/health` to verify that the load balancer routes correctly to the API container, and `http://<load_balancer_ip>/` to verify that it serves the React application.
