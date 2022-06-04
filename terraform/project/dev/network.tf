resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "dev-vpc"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "dev-subnet-1"
  }
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "dev-subnet-2"
  }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    "Name" = "dev-igw"
  }
}

resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "dev-rt"
  }
}

resource "aws_route_table_association" "dev-public-subnet-1" {
  subnet_id      = aws_subnet.dev-subnet-1.id
  route_table_id = aws_route_table.dev-rt.id
}

resource "aws_route_table_association" "dev-public-subnet-2" {
  subnet_id      = aws_subnet.dev-subnet-2.id
  route_table_id = aws_route_table.dev-rt.id
}


resource "aws_security_group" "dev-sg" {
  name   = "dev-sg"
  vpc_id = aws_vpc.dev-vpc.id

dynamic "ingress" {
    for_each = ["22", "3000", "3306"]
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