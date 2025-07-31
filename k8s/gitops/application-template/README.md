# ArgoCD Application Template
Argocd application template for deploying applications to a Kubernetes cluster using GitOps principles.

## Bootstrapping infrastructure
Run the following commands to bootstrap the infrastructure:

```bash
# Move to the bootstraps directory
cd bootstraps

# Spin up the infrastructure
./scripts/setup-infra.sh 
# Start the ArgoCD application
./scripts/start-argocd.sh
```

Here is the overview of the infrastructure that will be created:
```ascii
┌─────────────────────────────────────────────────────────┐
│                      Docker Host                        │
│                                                         │
│  ┌──────────────┐        ┌──────────────┐               │
│  │ Docker Net:  │        │ Docker Net:  │               │
│  │  k3d-platform         │  k3d-workload│               │
│  └──────┬───────┘        └──────┬───────┘               │
│         │                       │                       │
│   ┌─────▼─────┐           ┌─────▼─────┐                 │
│   │ k3d-platform          │ k3d-workload                │
│   │ serverlb  │           │ serverlb   │                │
│   │ (NGINX LB)│           │ (no ports) │                │
│   └─────┬─────┘           └─────┬──────┘                │
│         │                       │                       │
│  ┌──────▼──────┐          ┌─────▼──────┐                │
│  │ k3d-platform-          │ k3d-workload                │
│  │ server-0    │          │ server-0   │                │
│  │ (k3s edge)  │          │ (k3s edge) │                │
│  │ ┌────────┐  │          │ ┌────────┐ │                │
│  │ │ArgoCD  │  │          │ │Deployed apps              │
│  │ └────────┘  │          │ └────────┘ │                │
│  └─────────────┘          └────────────┘                │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

To clean up the infrastructure, run the following command:

```bash
./scripts/destroy-infra.sh
```
