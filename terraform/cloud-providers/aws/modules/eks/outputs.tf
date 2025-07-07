output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

output "cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL of the EKS cluster"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "cluster_security_group_id" {
  description = "The security group ID for the EKS cluster"
  value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}
