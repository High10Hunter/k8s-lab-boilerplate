# General Variables
variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the VM's network interface will be attached."
  type        = string
}

# Public IP Variables
variable "public_ip_name" {
  description = "The name of the public IP address."
  type        = string
}

variable "public_ip_allocation_method" {
  description = "The allocation method for the public IP address ('Static' or 'Dynamic')."
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "The SKU for the public IP address ('Basic' or 'Standard')."
  type        = string
  default     = "Standard"
}

# Network Interface Variables
variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}

# Virtual Machine Variables
variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine (e.g., 'Standard_D2s_v3')."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key for authenticating to the virtual machine."
  type        = string
}

variable "os_disk_caching" {
  description = "The caching type for the OS disk ('ReadWrite', 'ReadOnly', etc.)."
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The storage account type for the OS disk ('Standard_LRS', 'Premium_LRS', etc.)."
  type        = string
  default     = "Standard_LRS"
}

variable "image_publisher" {
  description = "The publisher of the VM image (e.g., 'Canonical')."
  type        = string
}

variable "image_offer" {
  description = "The offer of the VM image (e.g., 'UbuntuServer')."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the VM image (e.g., '18.04-LTS')."
  type        = string
}

variable "image_version" {
  description = "The version of the VM image (e.g., 'latest')."
  type        = string
  default     = "latest"
}

# Data Disk Variables
variable "data_disk_size_gb" {
  description = "The size of the data disk in GB. Set to 0 to disable data disk creation."
  type        = number
  default     = 0
}

variable "data_disk_storage_account_type" {
  description = "The storage account type for the data disk ('Standard_LRS', 'Premium_LRS', etc.)."
  type        = string
  default     = "Premium_LRS"
}

variable "data_disk_caching" {
  description = "The caching type for the data disk ('ReadWrite', 'ReadOnly', etc.)."
  type        = string
  default     = "ReadWrite"
}

# Tags
variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = {}
}
