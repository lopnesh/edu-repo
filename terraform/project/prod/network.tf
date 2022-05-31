resource "aws_vpc" "prod-vpc" {
  cidr_block           = "10.10.11.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "prod-vpc"
  }
}

resource "aws_subnet" "prod-subnet" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.10.11.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "prod-subnet"
  }
}

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    "Name" = "prod-igw"
  }
}

resource "aws_route_table" "prod-rt" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }

  tags = {
    Name = "prod-rt"
  }
}

resource "aws_route_table_association" "prod-public-subnet-1" {
  subnet_id      = aws_subnet.prod-subnet.id
  route_table_id = aws_route_table.prod-rt.id
}

resource "aws_security_group" "prod-sg" {
  name   = "prod-sg"
  vpc_id = aws_vpc.prod-vpc.id

dynamic "ingress" {
    for_each = ["22", "3000"]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}