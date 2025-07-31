#!/usr/bin/env bash
# Creates k3d clusters and installs Argo CD via Helm into the "platform" cluster.

set -euo pipefail
# Ensure k3d writes into your default kubeconfig file
unset KUBECONFIG
export KUBECONFIG="$HOME/.kube/config"

# 1) Create the "platform" cluster to install ArgoCD
echo "⏳ Creating k3d 'platform' cluster..."
k3d cluster create platform \
  --config ../manifests/k3d-platform.yaml \
  --kubeconfig-update-default \
  --kubeconfig-switch-context \
  --wait

# 2) Create the "workload" cluster (no context switch)
echo "⏳ Creating k3d 'workload' cluster..."
k3d cluster create workload \
  --config ../manifests/k3d-workload.yaml \
  --kubeconfig-update-default \
  --wait

# 4) Ensure kubeconfig is pointing at "platform" cluster
echo "✅ Clusters created. Current contexts:"
kubectl config get-contexts
kubectl config use-context k3d-platform

# 5) Add & update Helm repo, then install ArgoCD
echo "⏳ Installing Argo CD into 'platform' cluster namespace..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd \
  --namespace argocd --create-namespace \
  --version 7.8.26 \
  --set server.service.type=NodePort \
  --set server.service.nodePortHttps=30179 \
  --set configs.cm."kustomize\.buildOptions"="--enable-helm" \
  --set configs.cm."application\.sync\.impersonation\.enabled"="true"

echo "✅ Setup infra completed. ArgoCD should now be installing on 'platform' cluster."
