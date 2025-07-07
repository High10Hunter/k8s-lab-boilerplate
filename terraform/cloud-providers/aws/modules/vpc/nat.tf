# AWS EIP 
resource "aws_eip" "nat" {
  count  = var.environment == "prod" ? length(var.availability_zones) : 1
  domain = "vpc"
  tags = {
    Name         = var.environment == "prod" ? "${var.app_name}-${var.environment}-nat-eip-${element(var.availability_zones, count.index)}" : "${var.app_name}-${var.environment}-nat-eip"
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

# Nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.environment == "prod" ? length(var.availability_zones) : 1
  allocation_id = aws_eip.nat[count.index].allocation_id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.internet_gateway]
  tags = {
    Name         = var.environment == "prod" ? "${var.app_name}-${var.environment}-nat-gw-${element(var.availability_zones, count.index)}" : "${var.app_name}-${var.environment}-nat-gw"
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
