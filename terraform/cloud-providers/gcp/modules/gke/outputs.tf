output "cluster_id" {
  value = google_container_cluster.gke.id
}
output "cluster_name" {
  value = google_container_cluster.gke.name
}
output "cluster_endpoint" {
  value = google_container_cluster.gke.endpoint
}
output "node_pool_name" {
  value = google_container_node_pool.general.name
}
output "service_account_id" {
  value = google_service_account.gke.id
}
output "service_account_email" {
  value = google_service_account.gke.email
}
