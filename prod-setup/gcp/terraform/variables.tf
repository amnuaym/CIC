variable "project_id" {
  type        = string
  default     = "project-4cd20f4a-78e2-4a45-81d"
  description = "The GCP Project ID where resources will be deployed."
}

variable "region" {
  type        = string
  default     = "asia-southeast3"
  description = "The GCP region to deploy resources to."
}

variable "zone" {
  type        = string
  default     = "asia-southeast3-c"
  description = "The GCP zone to deploy resources to."
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
