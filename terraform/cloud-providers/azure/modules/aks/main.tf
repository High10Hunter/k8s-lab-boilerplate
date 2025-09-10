# Create User-Assigned Managed Identity
resource "azurerm_user_assigned_identity" "base" {
  name                = var.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Assign Role to the Identity
resource "azurerm_role_assignment" "base" {
  scope                = var.resource_group_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version        = var.kubernetes_version
  automatic_upgrade_channel = var.automatic_upgrade_channel
  private_cluster_enabled   = var.private_cluster_enabled
  node_resource_group       = var.node_resource_group

  sku_tier                   = var.sku_tier
  oidc_issuer_enabled        = var.oidc_issuer_enabled
  workload_identity_enabled  = var.workload_identity_enabled

  network_profile {
    network_plugin = var.network_plugin
    dns_service_ip = var.dns_service_ip
    service_cidr   = var.service_cidr
  }

  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.vm_size
    vnet_subnet_id       = var.vnet_subnet_id
    orchestrator_version = var.kubernetes_version
    type                 = var.node_pool_type
    auto_scaling_enabled = var.auto_scaling_enabled
    node_count           = var.initial_node_count
    min_count            = var.min_node_count
    max_count            = var.max_node_count

    temporary_name_for_rotation = "tempnodepool"

    node_labels = var.node_labels
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  depends_on = [
    azurerm_role_assignment.base
  ]
}
