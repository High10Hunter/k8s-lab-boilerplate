module "metrics-server" {
  source = "./metrics-server"
}

module "nginx-ingress" {
  source = "./nginx-ingress"
}

module "cert-manager" {
  source = "./cert-manager"
}
