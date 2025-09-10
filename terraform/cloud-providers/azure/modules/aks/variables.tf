# Identity Variables
variable "identity_name" {
  description = "The name of the user-assigned managed identity."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be created."
  type        = string
}

variable "resource_group_id" {
  description = "The ID of the resource group where the role assignment will be applied."
  type        = string
}

variable "role_definition_name" {
  description = "The role definition name for the role assignment (e.g., 'Network Contributor')."
  type        = string
}

# AKS Cluster Variables
variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the AKS cluster."
  type        = string
}

variable "automatic_upgrade_channel" {
  description = "The automatic upgrade channel for the AKS cluster."
  type        = string
}

variable "private_cluster_enabled" {
  description = "Whether the AKS cluster is private."
  type        = bool
}

variable "node_resource_group" {
  description = "The name of the node resource group for the AKS cluster."
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier for the AKS cluster ('Free' or 'Standard')."
  type        = string
}

variable "oidc_issuer_enabled" {
  description = "Whether the OIDC issuer is enabled for the AKS cluster."
  type        = bool
}

variable "workload_identity_enabled" {
  description = "Whether workload identity is enabled for the AKS cluster."
  type        = bool
}

variable "network_plugin" {
  description = "The network plugin for the AKS cluster ('azure' or 'kubenet')."
  type        = string
}

variable "dns_service_ip" {
  description = "The DNS service IP for the AKS cluster."
  type        = string
}

variable "service_cidr" {
  description = "The service CIDR for the AKS cluster."
  type        = string
}

variable "default_node_pool_name" {
  description = "The name of the default node pool."
  type        = string
}

variable "vm_size" {
  description = "The VM size for the default node pool."
  type        = string
}

variable "vnet_subnet_id" {
  description = "The subnet ID for the default node pool."
  type        = string
}

variable "node_pool_type" {
  description = "The type of the node pool ('VirtualMachineScaleSets' or 'AvailabilitySet')."
  type        = string
}

variable "auto_scaling_enabled" {
  description = "Whether auto-scaling is enabled for the default node pool."
  type        = bool
}

variable "initial_node_count" {
  description = "The initial number of nodes in the default node pool."
  type        = number
}

variable "min_node_count" {
  description = "The minimum number of nodes in the default node pool."
  type        = number
}

variable "max_node_count" {
  description = "The maximum number of nodes in the default node pool."
  type        = number
}

variable "node_labels" {
  description = "The labels to apply to the nodes in the default node pool."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the AKS cluster."
  type        = map(string)
  default     = {}
}
