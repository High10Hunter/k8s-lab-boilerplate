#!/usr/bin/env bash
# Creates k3d cluster.

set -euo pipefail
# Ensure k3d writes into your default kubeconfig file
unset KUBECONFIG
export KUBECONFIG="$HOME/.kube/config"

# 1) Create the "workload" cluster (no context switch)
echo "⏳ Creating k3d 'workload' cluster..."
k3d cluster create workload \
  --config ../manifests/k3d-workload.yaml \
  --kubeconfig-update-default \
  --wait

# 2) Ensure kubeconfig is pointing at "platform" cluster
echo "✅ Clusters created. Current contexts:"
kubectl config get-contexts
kubectl config use-context k3d-workload
