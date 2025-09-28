output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster"

}

output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "The endpoint of the GKE cluster"

}

output "artifact_registry_repo_url" {
  description = "The full url of the Artifact Registry Docker repository"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${var.artifact_registry_repo_name}"
}
