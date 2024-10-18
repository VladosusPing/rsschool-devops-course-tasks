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

# Outputs for Bastion EC2 Instance
output "prod_ec2_bastion_id" {
  description = "ID of the production Bastion EC2 instance"
  value       = aws_instance.prod-ec2-bastion.id
}

output "prod_ec2_bastion_public_ip" {
  description = "Public IP of the production Bastion EC2 instance"
  value       = aws_eip.bastion_eip.public_ip
}

# Outputs for K3s Cluster All-in-One EC2 Instance
output "prod_ec2_k3s_cluster_allinone_id" {
  description = "ID of the production K3s Cluster All-in-One EC2 instance"
  value       = aws_instance.prod-ec2-k3s-cluster-allinone.id
}

output "prod_ec2_k3s_cluster_allinone_public_ip" {
  description = "Public IP of the production K3s Cluster All-in-One EC2 instance"
  value       = aws_eip.k3s_cluster_eip.public_ip
}

# ID of the associated Elastic IP for Bastion
output "prod_eip_bastion_id" {
  description = "ID of the Elastic IP associated with the Bastion EC2 instance"
  value       = aws_eip.bastion_eip.id
}

# ID of the associated Elastic IP for K3s Cluster
output "prod_eip_k3s_cluster_id" {
  description = "ID of the Elastic IP associated with the K3s Cluster All-in-One EC2 instance"
  value       = aws_eip.k3s_cluster_eip.id
}