locals {
  environment = "quick-launch"
  project_id  = "high10hunter"
  region      = "us-central1"
  apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com"
  ]
  secondary_ip_ranges = {
    "k8s-pods"     = "172.16.0.0/14",
    "k8s-services" = "172.20.0.0/18"
  }
}
