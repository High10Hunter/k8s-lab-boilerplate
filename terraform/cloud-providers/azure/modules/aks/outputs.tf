# Outputs for User-Assigned Identity
output "identity_id" {
  description = "The ID of the user-assigned managed identity."
  value       = azurerm_user_assigned_identity.base.id
}

output "identity_principal_id" {
  description = "The principal ID of the user-assigned managed identity."
  value       = azurerm_user_assigned_identity.base.principal_id
}

# Outputs for AKS Cluster
output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL for the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "kube_config" {
  description = "The kubeconfig for accessing the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}
