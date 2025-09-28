//Confugre the Goole Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

//Enable required GCP APIs
resource "google_project_service" "gke_api" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact_registry_api" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

//Create a Vpc network for the GKE cluster
resource "google_compute_network" "main_vpc" {
  name                    = "${var.cluster_name}-vpc"
  auto_create_subnetworks = false
}

//Create a subnet for the cluster
resource "google_compute_subnetwork" "main_subnet" {
  name          = "${var.cluster_name}-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.main_vpc.id
}

//Create the GKE Autopilot cluster
resource "google_container_cluster" "primary" {
  name       = var.cluster_name
  location   = var.region
  network    = google_compute_network.main_vpc.id
  subnetwork = google_compute_subnetwork.main_subnet.id

  //Enable Autopilot mode
  enable_autopilot = true

  //Ensure APIs are enabled before creating the cluster
  depends_on = [
    google_project_service.gke_api
  ]
}

// Create the Artifact Registry repository for Docker images
resource "google_artifact_registry_repository" "main_repo" {
  provider      = google-beta
  location      = var.region
  repository_id = var.artifact_registry_repo_name
  description   = "Docker repository for application images"
  format        = "DOCKER"

  //Ensure APIs are enabled before creating the repo
  depends_on = [
    google_project_service.artifact_registry_api
  ]
}
