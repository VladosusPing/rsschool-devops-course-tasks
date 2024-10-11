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
}

### Instance Security group (traffic ALB -> EC2, ssh -> EC2)
resource "aws_security_group" "prod-ec2-sg" {
  name        = "prod-ec2-sg"
  description = "Allows inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id

  #  ingress {
  #    from_port       = 0
  #    to_port         = 0
  #    protocol        = "-1"
  #    security_groups = [aws_security_group.load-balancer.id]
  #  }

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
}
