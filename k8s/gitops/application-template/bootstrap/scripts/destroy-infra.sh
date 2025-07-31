#!/bin/bash

echo "k8s infrastructure destruction started..."

# Delete Argo CD Helm release and namespace
helm uninstall argocd -n argocd
kubectl delete namespace argocd --ignore-not-found

# Delete k3d clusters
k3d cluster delete dev
k3d cluster delete managed

echo "k8s infrastructure destruction finished. 🗑️"
