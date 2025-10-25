# Kubernetes lab boilerplate
A collection of tools and scripts to help you get started with Kubernetes in the local (or cloud) environment

## Requirements
- Minikube (or K3d, Kind, etc.)
- Kubie
- Terraform
- Kustomize
- Helm 
- Tools to manage Kubernetes resources (e.g: K9s, Lens, etc.)

## Setup KinD
```bash
sudo kind create cluster

# set the context to kind
kubie ctx kind-kind
```


## Minikube
### Config colima to work with minikube
```bash
colima start --cpu 4 --memory 8 --dns 8.8.8.8,1.1.1.1
```


### Setup minikube
```bash
# initalize the minikube cluster
minikube start --cpus <number_of_cpus> --memory <memory_usage> --kubernetes-version=<version> --driver=docker
# e.g: minikube start --cpus 2 --memory 4096 --kubernetes-version=v1.31 --driver=docker

# set the context to minikube
kubie ctx minikube
```


## Provision local resources on k8s cluster
```bash
cd terraform
cd local 
terraform init
terraform apply
```

## Launch infrastructure with GitOps 
- [Simple GitOps instruction](./k8s/gitops/simple/README.md)
[ArgoCD application template](./k8s/gitops/application-template/README.md)
