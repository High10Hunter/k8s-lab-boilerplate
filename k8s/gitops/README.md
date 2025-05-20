# GitOps instruction   

## Bootstrapping
Update custom ConfigMap with the IP of image registry in the k8s cluster and git repo secret so that ArgoCD can access the git repo

```bash
# Apply the bootstrap folder
cd k8s/gitops
kubectl apply -f bootstrap
```

## Launch the infrastructure 
Move into the `app-of-apps` folder and run the following command to launch the infrastructure

```bash
cd k8s/gitops/app-of-apps
kubectl apply -f application-<environment>.yaml
# e.g: kubectl apply -f application-dev.yaml
```

