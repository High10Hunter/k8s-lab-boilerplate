resource "google_container_node_pool" "general" {
  name    = "${var.environment}-general"
  cluster = google_container_cluster.gke.id

  autoscaling {
    total_min_node_count = var.min_node_count
    total_max_node_count = var.max_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.gke_machine_type

    labels = {
      role = "general"
    }

    service_account = google_service_account.gke.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
