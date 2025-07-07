# Check the latest version of the addon by running:
# aws eks describe-addon-versions --region us-east-1 --addon-name eks-pod-identity-agent
resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.7-eksbuild.2"
}
