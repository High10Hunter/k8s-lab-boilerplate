resource "azurerm_user_assigned_identity" "aks_uai" {
  name                = "${local.env}-aks-identity"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_federated_identity_credential" "dev_credential" {
  resource_group_name = local.resource_group_name
  parent_id           = azurerm_user_assigned_identity.aks_uai.id
  name                = "aks-federated-credential"
  audience            = ["api://AzureADTokenExchange"]
  issuer              = module.aks.oidc_issuer_url
  subject             = "system:serviceaccount:${local.resource_group_name}-secrets:external-secret-sa"

  depends_on = [module.aks]
}
