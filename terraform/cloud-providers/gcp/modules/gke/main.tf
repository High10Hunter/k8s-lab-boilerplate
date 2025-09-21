resource "google_container_cluster" "gke" {
  name                     = var.cluster_name
  location                 = "${var.region}-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_id
  subnetwork               = var.private_subnet_id
  networking_mode          = "VPC_NATIVE"
  deletion_protection      = false

  # Optional, if you want multi-zonal cluster
  # node_locations = ["us-central1-b"]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pods"
    services_secondary_range_name = "k8s-services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }

  # Jenkins use case
  # master_authorized_networks_config {
  #   cidr_blocks {
  #     cidr_block   = "10.0.0.0/18"
  #     display_name = "private-subnet"
  #   }
  # }
}
