# main vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# subnets
resource "aws_subnet" "prod-public-subnet-us-east-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_us-east-1a_subnet_cidr
  availability_zone = "us-east-1a"


  tags = {
    Name            = "prod-public-subnet-us-east-1a" 
    Env             = "prod"
    Owner           = "vladislav"
    Project         = "devops-learning"
  }
}

resource "aws_subnet" "prod-public-subnet-us-east-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_us-east-1b_subnet_cidr
  availability_zone = "us-east-1b"


  tags = {
    Name            = "prod-public-subnet-us-east-1b"
    Env             = "prod"
    Owner           = "vladislav"
    Project         = "devops-learning"
  }
}

resource "aws_subnet" "prod-private-subnet-us-east-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_us-east-1a_subnet_cidr
  availability_zone = "us-east-1a"


  tags = {
    Name            = "prod-private-subnet-us-east-1a"
    Env             = "prod"
    Owner           = "vladislav"
    Project         = "devops-learning"
  }
}

resource "aws_subnet" "prod-private-subnet-us-east-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_us-east-1b_subnet_cidr
  availability_zone = "us-east-1b"


  tags = {
    Name            = "prod-private-subnet-us-east-1b"
    Env             = "prod"
    Owner           = "vladislav"
    Project         = "devops-learning"
  }
}

# Gateways

resource "aws_internet_gateway" "prod-igw" {
  tags = {
    Name = "prod-igw"
  }
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "prod-nat-gw-eip" {
  vpc                       = true
  associate_with_private_ip = "10.0.1.1"
  depends_on                = [aws_internet_gateway.prod-igw]
}

resource "aws_nat_gateway" "prod-nat-gw" {
  allocation_id = aws_eip.prod-nat-gw-eip.id
  subnet_id     = aws_subnet.prod-public-subnet-us-east-1a.id

  tags = {
    Name = "prod-nat-gw"
  }
  depends_on = [aws_eip.prod-nat-gw-eip]
}

