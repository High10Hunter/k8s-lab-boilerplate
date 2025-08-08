#!/bin/bash

echo "k8s infrastructure destruction started..."

# Delete Argo CD Helm release and namespace
helm uninstall argocd -n argocd
kubectl delete namespace argocd --ignore-not-found

# Delete k3d clusters
k3d cluster delete platform
k3d cluster delete workload

echo "k8s infrastructure destruction finished. 🗑️"
