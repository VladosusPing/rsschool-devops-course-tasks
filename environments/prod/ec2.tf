#EC2 resources
resource "aws_instance" "prod-ec2-bastion" {
  ami           = var.amis
  instance_type = var.instance_type
  subnet_id     = aws_subnet.prod-public-subnet-us-east-1a.id
  vpc_security_group_ids = [ aws_security_group.prod-bastion-sg.id ]
  key_name = aws_key_pair.terraform-lab.key_name
  
  root_block_device {
    volume_size = 10
    volume_type = var.volume_type
  }

  tags = {
    Name = "prod-bastion00"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}

resource "aws_instance" "prod-ec2-k3s-cluster-allinone" {
  ami           = var.amis
  instance_type = var.instance_type
  subnet_id     = aws_subnet.prod-public-subnet-us-east-1b.id
  vpc_security_group_ids = [ aws_security_group.prod-ec2-sg.id ]
  key_name = aws_key_pair.terraform-lab.key_name
  
  user_data = file(var.k3s_installation_script)

  root_block_device {
    volume_size = 20
    volume_type = var.volume_type
  }

  tags = {
    Name = "prod-ec2-k3s-cluster-allinone"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}

### Associate ec2 with eips 
resource "aws_eip_association" "eip_bastion_assoc" {
  instance_id   = aws_instance.prod-ec2-bastion.id
  allocation_id = aws_eip.bastion_eip.id
}

resource "aws_eip_association" "eip_k3d_assoc" {
  instance_id   = aws_instance.prod-ec2-k3s-cluster-allinone.id
  allocation_id = aws_eip.k3s_cluster_eip.id
}