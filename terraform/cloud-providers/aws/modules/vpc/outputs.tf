output "vpc_id" {
  description = "The ID of VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The list of Public Subnet IDs"
  value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  description = "The list of Private Subnet IDs"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}
