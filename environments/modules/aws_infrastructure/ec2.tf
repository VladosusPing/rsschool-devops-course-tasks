#EC2 resources
resource "aws_instance" "prod-ec2-bastion" {
  ami                    = var.amis
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.prod-public-subnet-us-east-1a.id
  vpc_security_group_ids = [aws_security_group.prod-bastion-sg.id]
  key_name               = aws_key_pair.terraform-lab.key_name

  root_block_device {
    volume_type = "gp3" # Specifies that this is a gp3 volume
    volume_size = 8     # Volume size in GB
    iops        = 3000  # gp3 allows custom IOPS, with a minimum of 3,000
    throughput  = 125   # You can specify throughput in MiB/s, minimum is 125 for gp3
  }

  user_data = <<EOF
    #!/bin/bash
    hostname bastion_host
    apt-get update
    apt-get install -y iptables
    
    # Install and start the SSM agent
    snap install amazon-ssm-agent --classic
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    
    # Install NGINX and start
    apt-get -y install nginx
    systemctl enable nginx
    systemctl start nginx
    
    # Enable IP forwarding for routing
    echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf
    
    # Set up NAT to allow private instances to access the internet through Bastion
    iptables -t nat -A POSTROUTING -o ens5 -s 0.0.0.0/0 -j MASQUERADE
  EOF

  tags = {
    Name    = "prod-bastion00"
    Project = var.tag_project
    Owner   = var.tag_owner
    Env     = var.tag_env
  }
}

resource "aws_instance" "prod-ec2-k3s-cluster-allinone" {
  ami                    = var.amis
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.prod-public-subnet-us-east-1b.id
  vpc_security_group_ids = [aws_security_group.prod-ec2-sg.id]
  key_name               = aws_key_pair.terraform-lab.key_name

  user_data = templatefile("${var.k3s_installation_script}", { k3s_config_base64 = base64encode(aws_ssm_parameter.k3s_config.value) })
  /*  <<EOF
    #!/bin/bash
    exec > /var/log/user-data.log 2>&1
    set -x
    # Update the package database and install necessary dependencies
    apt-get update
    apt-get install -y curl

    # Disable swap (Kubernetes requires swap to be disabled)
    swapoff -a

    # Install K3s using the official K3s install script
    curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=latest sh - 

    echo ${aws_ssm_parameter.k3s_config.value} > /etc/rancher/k3s/k3s.yaml
    systemctl restart k3s.service
  
    # Install helm using the official helm install script
    curl -fsSL -o /var/tmp/get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 /var/tmp/get_helm.sh
    . /var/tmp/get_helm.sh

    # Optional: Enable K3s to start on boot
    systemctl enable k3s

    # Cleanup
    apt-get autoremove -y
    apt-get clean

    echo "K3s all-in-one cluster installation complete. You can verify with 'kubectl get nodes'."
  EOF*/

  root_block_device {
    volume_type = "gp3" # Specifies that this is a gp3 volume
    volume_size = 16    # Volume size in GB
    iops        = 3000  # gp3 allows custom IOPS, with a minimum of 3,000
    throughput  = 125   # You can specify throughput in MiB/s, minimum is 125 for gp3
  }

  tags = {
    Name    = "prod-ec2-k3s-cluster-allinone"
    Project = var.tag_project
    Owner   = var.tag_owner
    Env     = var.tag_env
  }
  depends_on = [aws_instance.prod-ec2-bastion, aws_ssm_parameter.k3s_config]
}

### Associate ec2 with eips 
resource "aws_eip_association" "eip_bastion_assoc" {
  instance_id   = aws_instance.prod-ec2-bastion.id
  allocation_id = aws_eip.bastion_eip.id
  depends_on    = [aws_instance.prod-ec2-bastion]
}

resource "aws_eip_association" "eip_k3s_assoc" {
  instance_id   = aws_instance.prod-ec2-k3s-cluster-allinone.id
  allocation_id = aws_eip.k3s_cluster_eip.id
  depends_on    = [aws_instance.prod-ec2-k3s-cluster-allinone]
}
