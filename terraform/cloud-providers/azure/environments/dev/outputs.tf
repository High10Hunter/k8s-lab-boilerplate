output "load_balancer_public_ip" {
  description = "Public IP of the Load Balancer VM."
  value       = module.load_balancer.public_ip_address
}
