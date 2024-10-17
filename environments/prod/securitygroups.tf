# Security groups file

### ALB Security Group (Traffic Internet -> ALB)
resource "aws_security_group" "prod-load-balancer-sg" {
  name        = "prod-load-balancer-sg"
  description = "Controls access to the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prod-load-balancer-sg"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}

### Instance Security group (traffic ALB -> EC2, ssh -> EC2)
resource "aws_security_group" "prod-ec2-sg" {
  name        = "prod-ec2-sg"
  description = "Allows inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Allow 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prod-ec2-sg"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}


### Bastion Security group (traffic Internet -> Bastion, Bastion -> EC2)
resource "aws_security_group" "prod-bastion-sg" {
  name        = "prod-bastion-sg"
  description = "Allows inbound ssh access from internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prod-bastion-sg"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}
