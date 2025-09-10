provider "azurerm" {
  features {}
  subscription_id = "766b9ec2-8032-468a-a864-8186c974e23c"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.15.0"
    }
  }
}
