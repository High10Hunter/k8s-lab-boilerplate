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
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}
variable "public_subnet_cidr" {
  type        = string
  description = "The CIDR block for the public subnet"
}
variable "private_subnet_cidr" {
  type        = string
  description = "The CIDR block for the private subnet"
}
variable "secondary_ip_ranges" {
  type        = map(string)
  description = "A map of secondary IP ranges for the subnet"
}
