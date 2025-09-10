# Virtual Network Variables
variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the VPC and subnets will be created."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the virtual network."
  type        = map(string)
  default     = {}
}

# Subnet Variables
variable "subnets" {
  description = "A list of subnet configurations."
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}
