output "jenkins_instance_name" {
  value       = google_compute_instance.jenkins.name
  description = "The name of the Jenkins VM instance."
}

output "jenkins_instance_zone" {
  value       = google_compute_instance.jenkins.zone
  description = "The zone of the Jenkins VM instance."
}
