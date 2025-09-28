terraform {
  backend "gcs" {
    bucket = "gke-showcase-tfstate-bucket-467916"
    prefix = "terraform/state"
  }
}
