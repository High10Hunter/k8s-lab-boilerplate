#!/bin/bash

sudo kind create cluster --name kind --config ./yamls/bootstrap/kind.yaml
echo "Kind cluster created ☸️"
sudo kubectl config use-context kind-kind

clusterctl init --infrastructure docker --config ./yamls/bootstrap/clusterctl.yaml
echo "Install the CAPI Management Cluster components completed ✈️"
