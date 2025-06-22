terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.15.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  # config_context = "minikube"
  config_context = "kind-kind"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
