resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
}

module "vnet" {
  source = "../modules/vnet"

  vnet_name           = "main"
  vnet_address_space  = var.vnet_address_space
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags = {
    env = local.env
  }

  private_subnets = [
    {
      name             = "private-subnet"
      address_prefixes = var.private_subnet_cidr_blocks
    }
  ]

  public_subnets = [
    {
      name             = "public-subnet"
      address_prefixes = var.public_subnet_cidr_blocks
    }
  ]

  # Private routes
  private_routes = {
    internal = {
      name           = "internal-traffic"
      address_prefix = var.private_subnet_cidr_blocks[0]
      next_hop_type  = "VnetLocal"
    }
  }

  # Public routes 
  public_routes = {
    internet = {
      name           = "internet-outbound"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    },
    internal = {
      name           = "internal-traffic"
      address_prefix = var.public_subnet_cidr_blocks[0]
      next_hop_type  = "VnetLocal"
    }
  }
}

module "aks" {
  source = "../modules/aks"

  identity_name        = "base"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  resource_group_id    = azurerm_resource_group.this.id
  role_definition_name = "Network Contributor"

  cluster_name              = "${local.env}-${local.aks_name}"
  dns_prefix                = "demo"
  kubernetes_version        = local.aks_version
  automatic_upgrade_channel = "stable"
  private_cluster_enabled   = false
  node_resource_group       = "${local.resource_group_name}-${local.env}-${local.aks_name}"
  sku_tier                  = "Free"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_plugin = var.network_plugin
  dns_service_ip = var.dns_service_ip
  service_cidr   = var.service_cidr

  default_node_pool_name = "general"
  vm_size                = "Standard_B2s"
  vnet_subnet_id         = module.vnet.public_subnet_ids[0]
  node_pool_type         = "VirtualMachineScaleSets"
  auto_scaling_enabled   = true
  initial_node_count     = 3
  min_node_count         = 1
  max_node_count         = 3

  node_labels = {
    role = "general"
  }

  tags = {
    env = local.env
  }
}
