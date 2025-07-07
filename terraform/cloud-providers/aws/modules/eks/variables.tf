variable "environment" {
  type        = string
  description = "The environment for the EKS cluster, used in naming conventions."
  default     = "dev"
}

variable "region" {
  type        = string
  description = "The AWS region where the EKS cluster will be created."
  default     = "us-east-1"
}

variable "eks_name" {
  type        = string
  description = "The name of the EKS cluster."
  default     = "demo"
}

variable "eks_version" {
  type        = string
  description = "The Kubernetes version for the EKS cluster."
  default     = "1.31"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
