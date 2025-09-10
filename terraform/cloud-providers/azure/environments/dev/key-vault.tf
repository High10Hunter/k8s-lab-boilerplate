resource "random_string" "kvname" {
  length  = 3
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aks_kv" {
  name                     = "external-secrets-kv-${random_string.kvname.result}"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Purge"
    ]
    key_permissions         = ["Get", "List"]
    certificate_permissions = ["Get", "List"]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.aks_uai.principal_id

    secret_permissions      = ["Get", "List"]
    key_permissions         = ["Get", "List"]
    certificate_permissions = ["Get", "List"]
  }
}
