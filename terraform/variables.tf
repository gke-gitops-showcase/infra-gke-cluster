//Gcp project settings
variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The Gcp region in which to provision resources."
  type        = string
  default     = "europe-west1" //Belgium
}

//Gcp Cluster settings
variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "gitops-cluster"
}

//Artifact repository settings
variable "artifact_registry_repo_name" {
  description = "The name of the Artifact Registry repository."
  type        = string
  default     = "app-images"
}

//Argo CD Root App Settings
variable "gitops_repo_url" {
  description = "The URL of the 'app-of-apps' repository."
  type        = string
  default     = "https://gitlab.com/gke-gitops-showcase/argocd-app-of-apps.git"
}
