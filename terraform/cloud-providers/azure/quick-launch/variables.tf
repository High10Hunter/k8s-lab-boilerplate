variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.0.0/19"]
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.32.0/19"]
}

variable "network_plugin" {
  default = "azure"
}

variable "dns_service_ip" {
  default = "10.0.64.10"
}

variable "service_cidr" {
  default = "10.0.64.0/19"
}

variable "location" {
  default = "eastus2"
}
