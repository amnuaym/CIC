
# ---------- Resource Policy for Daily Start/Stop ----------
resource "google_compute_resource_policy" "jenkins_schedule" {
  name        = "jenkins-daily-schedule"
  description = "Start at 07:00, stop at 21:00 daily (Asia/Jakarta)"
  region      = var.region

  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 7 * * *"
    }
    vm_stop_schedule {
      schedule = "0 21 * * *"
    }
    time_zone = "Asia/Jakarta"
  }
}

# ---------- Jenkins VM Instance ----------
resource "google_compute_instance" "jenkins" {
  name         = "jenkins-ci"
  machine_type = "e2-small"   # 2 vCPU, 2 GB RAM – minimal for CI workloads
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10          # GB, enough for Jenkins home & Docker images
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {} # Assign ephemeral external IP (required for IAP tunneling)
  }

  # Attach the schedule policy defined above
  resource_policies = [google_compute_resource_policy.jenkins_schedule.id]

  # Service account with minimal roles for Artifact Registry and GKE
  service_account {
    email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  tags = ["jenkins"]
}

# ---------- Service Account ----------
# Using existing service account: cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com

# Grant minimal IAM roles to the service account
resource "google_project_iam_member" "artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_deployer" {
  project = var.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"
}


