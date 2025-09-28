# Local setup for Cluster API

## Start colima 
```bash
colima start --runtime docker --cpu 4 --memory 8 --disk 40
docker context use colima
```

Make `/var/run/docker.sock` available on the host:
```bash
# default profile
sudo ln -sf "${HOME}/.colima/default/docker.sock" /var/run/docker.sock
# if you used --profile k8s, then:
# sudo ln -sf "${HOME}/.colima/k8s/docker.sock" /var/run/docker.sock

```

## Create kind management cluster with socket mount:
```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraMounts:
  - hostPath: /var/run/docker.sock
    containerPath: /var/run/docker.sock
```

```bash
sudo kind create cluster --name kind --config kind.yaml
```

## Increase inotify + ulimits inside Colima
```bash 
colima ssh
# inside the VM:
echo 'fs.inotify.max_user_instances=1024' | sudo tee /etc/sysctl.d/60-inotify.conf
echo 'fs.inotify.max_user_watches=1048576' | sudo tee -a /etc/sysctl.d/60-inotify.conf
echo 'fs.inotify.max_queued_events=65536' | sudo tee -a /etc/sysctl.d/60-inotify.conf
sudo sysctl --system
```

## Initialize Cluster API for local management cluster
```bash 
./scripts/init-kind-cluster-api.sh
```
