# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name                                                       = "${var.app_name}-${var.environment}-public-${element(var.availability_zones, count.index)}"
    "kubernetes.io/cluster/${var.environment}-${var.app_name}" = "owned"
    "kubernetes.io/role/elb"                                   = "1"
    Created_By                                                 = "Terraform"
    Environment                                                = var.environment
    Created_Time                                               = timestamp()
  }
  lifecycle {
    ignore_changes = [
      tags["Created_Time"]
    ]
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 11)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "false"
  tags = {
    Name                                                       = "${var.app_name}-${var.environment}-private-${element(var.availability_zones, count.index)}"
    Created_By                                                 = "Terraform"
    "kubernetes.io/cluster/${var.environment}-${var.app_name}" = "owned"
    "kubernetes.io/role/internal-elb"                          = "1"
    Environment                                                = var.environment
    Created_Time                                               = timestamp()
  }
  lifecycle {
    ignore_changes = [
      tags["Created_Time"]
    ]
  }
}
