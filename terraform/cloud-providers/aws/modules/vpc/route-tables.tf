# Public route tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name         = "${var.app_name}-${var.environment}-public-rtb"
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

# Public route associations
resource "aws_route_table_association" "public_association" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private route tables
resource "aws_route_table" "private_route_table" {
  count = var.environment == "prod" ? length(var.availability_zones) : 1
  # count  = 1
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.environment == "prod" ? aws_nat_gateway.nat_gateway[count.index].id : aws_nat_gateway.nat_gateway[0].id
  }
  tags = {
    Name         = "${var.app_name}-${var.environment}-private-rtb-${element(var.availability_zones, count.index)}"
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

# Private route associations
resource "aws_route_table_association" "private_association" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = var.environment == "prod" ? aws_route_table.private_route_table[count.index].id : aws_route_table.private_route_table[0].id
}
