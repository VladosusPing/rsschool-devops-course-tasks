### Main vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

### Subnets
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
  vpc_id                     = aws_vpc.main.id
  cidr_block                 = var.private_us-east-1b_subnet_cidr
  availability_zone          = "us-east-1b"


  tags = {
    Name                     = "prod-private-subnet-us-east-1b"
    Env                      = "prod"
    Owner                    = "vladislav"
    Project                  = "devops-learning"
  }
}

### Gateways

resource "aws_internet_gateway" "prod-igw" {
  tags = {
    Name                    = "prod-igw"
  }
  vpc_id                    = aws_vpc.main.id
}

# Elastic IP for IGW

resource "aws_eip" "prod-nat-gw-eip" {
  vpc                       = true
  associate_with_private_ip = "10.0.1.1"
  depends_on                = [aws_internet_gateway.prod-igw]
}

resource "aws_nat_gateway" "prod-nat-gw" {
  allocation_id             = aws_eip.prod-nat-gw-eip.id
  subnet_id                 = aws_subnet.prod-public-subnet-us-east-1a.id

  tags = {
    Name                    = "prod-nat-gw"
  }
  depends_on                = [aws_eip.prod-nat-gw-eip]
}

### Route tables for the subnets

resource "aws_route_table" "public-route-table" {
  vpc_id                    = aws_vpc.main.id
  tags = {
    Name                    = "public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-route-table"
  }
}


### Route the public subnet traffic through the Internet Gateway

resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.prod-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

### Route NAT Gateway

resource "aws_route" "nat-ngw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.prod-nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

### Associate the newly created route tables to the subnets

resource "aws_route_table_association" "prod-public-subnet-us-east-1a-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.prod-public-subnet-us-east-1a.id
}

resource "aws_route_table_association" "prod-public-subnet-us-east-1b-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.prod-public-subnet-us-east-1b.id
}

resource "aws_route_table_association" "prod-private-subnet-us-east-1a-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.prod-private-subnet-us-east-1a.id
}

resource "aws_route_table_association" "prod-private-subnet-us-east-1b-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.prod-private-subnet-us-east-1b.id
}
