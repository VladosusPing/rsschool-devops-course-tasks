resource "aws_instance" "first_instance" {
  ami           = var.amis
  instance_type = var.instance_type
  subnet_id     = aws_subnet.prod-public-subnet-us-east-1a.id
  security_groups = [ aws_security_group.prod-bastion-sg.name ]

  tags = {
    Name = "prod-bastion00"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}

