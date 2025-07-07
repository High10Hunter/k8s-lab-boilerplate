locals {
  vpc_name              = "${var.app_name}-${var.environment}-vpc"
  internet_gateway_name = "${var.app_name}-${var.environment}-internet-gw"
}

### VPC ###
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name         = local.vpc_name
    Created_By   = "Terraform"
    Environment  = var.environment
    Created_Time = timestamp()
  }
  lifecycle {
    ignore_changes = [
      tags["Created_Time"]
    ]
  }
}

### Internet Gateway ###
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name         = local.internet_gateway_name
    Created_By   = "Terraform"
    Environment  = var.environment
    Created_Time = timestamp()
  }
  lifecycle {
    ignore_changes = [
      tags["Created_Time"]
    ]
  }
}
