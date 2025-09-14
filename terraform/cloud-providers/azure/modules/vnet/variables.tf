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
  description = "Tags to apply to the virtual network and associated resources."
  type        = map(string)
  default     = {}
}

# Subnet Variables
variable "subnets" {
  description = "A list of subnet configurations. DEPRECATED: Use private_subnets and public_subnets instead."
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = []
}

variable "private_subnets" {
  description = "A list of private subnet configurations."
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = []
}

variable "public_subnets" {
  description = "A list of public subnet configurations."
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = []
}

# Route Table Variables
variable "create_private_route_table" {
  description = "Whether to create a route table for private subnets."
  type        = bool
  default     = true
}

variable "create_public_route_table" {
  description = "Whether to create a route table for public subnets."
  type        = bool
  default     = true
}

variable "private_route_table_name" {
  description = "Name for the private route table. If not provided, defaults to '{vnet_name}-private-rt'."
  type        = string
  default     = null
}

variable "public_route_table_name" {
  description = "Name for the public route table. If not provided, defaults to '{vnet_name}-public-rt'."
  type        = string
  default     = null
}

variable "private_routes" {
  description = "A map of routes to add to the private route table."
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "public_routes" {
  description = "A map of routes to add to the public route table."
  type = map(object({
    name           = string
    address_prefix = string
    # Next hop types: Internet, VnetLocal, VirtualNetworkGateway, VirtualAppliance, None
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {
    internet = {
      name           = "internet"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  }
}

variable "disable_bgp_route_propagation" {
  description = "Boolean flag which controls propagation of routes learned by BGP on the route table."
  type        = bool
  default     = false
}

# Advanced Configuration
variable "associate_route_tables" {
  description = "Whether to automatically associate route tables with their respective subnets."
  type        = bool
  default     = true
}

variable "enable_ddos_protection" {
  description = "Enable DDoS protection on the virtual network."
  type        = bool
  default     = false
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDoS protection plan to associate with the virtual network."
  type        = string
  default     = null
}

