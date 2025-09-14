module "vpc" {
  source = "../../modules/vnet"

  vnet_name           = "main"
  vnet_address_space  = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags = {
    env = local.env
  }

  subnets = [
    {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/19"]
    },
    {
      name             = "subnet2"
      address_prefixes = ["10.0.32.0/19"]
    }
  ]
}

module "aks" {
  source = "../../modules/aks"

  identity_name        = "base"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  resource_group_id    = azurerm_resource_group.this.id
  role_definition_name = "Network Contributor"

  cluster_name              = "${local.env}-${local.aks_name}"
  dns_prefix                = "devsimpleshopping"
  kubernetes_version        = local.aks_version
  automatic_upgrade_channel = "stable"
  private_cluster_enabled   = false
  node_resource_group       = "${local.resource_group_name}-${local.env}-${local.aks_name}"
  sku_tier                  = "Free"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_plugin = "azure"
  dns_service_ip = "10.0.64.10"
  service_cidr   = "10.0.64.0/19"

  default_node_pool_name = "general"
  vm_size                = "Standard_B2s"
  vnet_subnet_id         = module.vpc.subnet_ids[0]
  node_pool_type         = "VirtualMachineScaleSets"
  auto_scaling_enabled   = true
  initial_node_count     = 3
  min_node_count         = 3
  max_node_count         = 10

  node_labels = {
    role = "general"
  }

  tags = {
    env = local.env
  }
}

# Load Balancer Server VM
module "load_balancer" {
  source = "../../modules/vm"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.vpc.subnet_ids[0]

  public_ip_name              = "load-balancer-ip"
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Basic"

  network_interface_name = "load-balancer-nic"
  vm_name                = "load-balancer"
  vm_size                = "Standard_B1ms"
  admin_username         = "azureuser"
  ssh_public_key         = file("${path.module}/ssh_keys/id_rsa_dev.pub")

  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"
  image_version   = "latest"

  os_disk_storage_account_type = "Standard_LRS"
  data_disk_size_gb            = 30

  tags = {
    env  = local.env
    role = "load-balancer"
  }
}
