#!/usr/bin/env bash
# Bootstraps Argo CD: merge kubeconfigs, switch to argo, wait for pods, set admin password, patch URL & RBAC.

set -euo pipefail

echo "🔀 Merging 'workload' kubeconfig into default…"
k3d kubeconfig merge workload --kubeconfig-merge-default

echo "🔀 Ensuring context is 'k3d-platform'…"
kubie ctx k3d-platform

echo "⌛ Waiting for Argo CD deployments to roll out…"
kubectl rollout status sts/argocd-application-controller -n argocd
kubectl rollout status deployment/argocd-server -n argocd

echo "🔑 Bootstrapping Argo CD admin password to 'password'…"
argopass=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d)
argocd login localhost:30179 --insecure --username admin \
  --password "$argopass" --grpc-web
argocd account update-password \
  --insecure \
  --current-password "$argopass" \
  --new-password "password"

echo "🔧 Patching argocd-cm.data.url → https://localhost:30179…"
kubectl patch cm/argocd-cm -n argocd --type json \
  -p='[{"op":"replace","path":"/data/url","value":"https://localhost:30179"}]'

echo "👮 Applying cluster-admin service account for ArgoCD sync operations."
kubectl apply -f ../manifests/argocd-configupdate.yaml

echo "✅ Start ArgoCD complete. Browse https://localhost:30179 (user: admin / password: password)."
