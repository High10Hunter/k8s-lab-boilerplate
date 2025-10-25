#!/bin/bash

set -euo pipefail

### SETTINGS ###
# Chart versions
NGINX_CHART_VERSION=4.12.0
CERTM_CHART_VERSION=v1.16.0
ARGOCD_CHART_VERSION=7.8.20

### Namespaces ###
NS_NGINX=ingress-nginx
NS_CERTM=cert-manager
NS_ARGO=argocd

### REPOS ###
echo "==> Adding Helm repos"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx >/dev/null 2>&1 || true
helm repo add jetstack https://charts.jetstack.io >/dev/null 2>&1 || true
helm repo add argo https://argoproj.github.io/argo-helm >/dev/null 2>&1 || true

echo "==> Updating Helm repos"
helm repo update

# ingress-nginx
echo "==> Installing/Upgrading ingress-nginx"
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  -n "$NS_NGINX" \
  --create-namespace \
  --wait \
  --version "$NGINX_CHART_VERSION" \
  -f ./ingress-nginx-values.yaml

# cert-manager (with CRDs)
echo "==> Installing/Upgrading cert-manager (includes CRDs)"
helm upgrade --install cert-manager jetstack/cert-manager \
  -n "$NS_CERTM" \
  --create-namespace \
  --wait \
  --version "$CERTM_CHART_VERSION" \
  --set crds.enabled=true

# Argo CD
echo "==> Installing/Upgrading Argo CD"
helm upgrade --install argocd argo/argo-cd \
  -n "$NS_ARGO" \
  --create-namespace \
  --wait \
  --version "$ARGOCD_CHART_VERSION" \
  -f ./argocd-values.yaml

### STATUS ###
echo "==> Helm addons installation done"
