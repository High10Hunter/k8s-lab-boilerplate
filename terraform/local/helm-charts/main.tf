module "argocd" {
  source = "./argocd"
}

module "rabbitmq" {
  source = "./rabbitmq"
}

module "keda" {
  source = "./keda"
}
