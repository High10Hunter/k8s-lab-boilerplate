resource "azurerm_managed_disk" "database_disk" {
  name                 = "database-storage-disk"
  location             = azurerm_resource_group.this.location
  resource_group_name  = data.azurerm_kubernetes_cluster.this.node_resource_group
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}
