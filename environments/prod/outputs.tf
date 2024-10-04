# This file contain outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "prod_private_us-east-1a_subnet_id" {
  description = "ID of the prod private us-east-1a subnet"
  value       = aws_subnet.prod-private-subnet-us-east-1a.id
}

output "prod_private_us-east-1b_subnet_id" {
  description = "ID of the prod private us-east-1b subnet"
  value       = aws_subnet.prod-private-subnet-us-east-1b.id
}

output "prod_public_us-east-1a_subnet_id" {
  description = "ID of the prod public us-east-1a subnet"
  value       = aws_subnet.prod-public-subnet-us-east-1a.id
}

output "prod_public_us-east-1b_subnet_id" {
  description = "ID of the prod public us-east-1b subnet"
  value       = aws_subnet.prod-public-subnet-us-east-1b.id
}

