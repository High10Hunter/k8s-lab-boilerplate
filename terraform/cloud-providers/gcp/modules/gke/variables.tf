variable "environment" {
  type        = string
  description = "The environment for the VPC (e.g., dev, staging, prod)"
}
variable "project_id" {
  type        = string
  description = "The GCP project ID"
}
variable "region" {
  type        = string
  description = "The GCP region"
}
variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the GKE cluster will be deployed"
}
variable "private_subnet_id" {
  type        = string
  description = "The ID of the private subnet for the GKE cluster"
}
variable "secondary_ip_ranges" {
  type        = map(string)
  description = "A map of secondary IP ranges for the GKE cluster"
}
variable "gke_machine_type" {
  type        = string
  description = "The machine type for the GKE nodes"
}
variable "min_node_count" {
  type    = number
  default = 1
}
variable "max_node_count" {
  type    = number
  default = 3
}
