variable "app_name" {
  type        = string
  description = "App name"
  default     = "demo"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
  default     = ""
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "environment" {
  type        = string
  description = "Environment name"
  validation {
    condition     = contains(["dev", "uat", "prod"], var.environment)
    error_message = "Invalid environment selected, only allowed environments are: 'dev', 'uat', 'prod'."
  }
}
