# This file contain outputs
output "prod_ec2_bastion_public_ip" {
  description = "Public IP of the production Bastion EC2 instance"
  value       = module.aws_infrastructure.prod_eip_bastion_ip
}

output "prod_ec2_k3s_cluster_allinone_public_ip" {
  description = "Public IP of the production K3s Cluster All-in-One EC2 instance"
  value       =  module.aws_infrastructure.prod_eip_k3s_cluster_ip
}