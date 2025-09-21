output "vpc_id" {
  value = google_compute_network.vpc.id
}
output "vpc_name" {
  value = google_compute_network.vpc.name
}
output "public_subnet_id" {
  value = google_compute_subnetwork.public.id
}
output "private_subnet_id" {
  value = google_compute_subnetwork.private.id
}
output "nat_ip" {
  value = google_compute_address.nat.address
}
