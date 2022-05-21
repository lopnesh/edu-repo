terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  ssh_user         = "ubuntu"
  key_name         = "ansible-da"
  private_key_path = "~/.ssh/ansible-da.pem"
}

resource "aws_vpc" "dev" {
  cidr_block = "10.10.10.0/24"
}

resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.10.10.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "dev-subnet"
  }
}

resource "aws_security_group" "dev-sg" {
  name   = "dev-sg"
  vpc_id = aws_vpc.dev.id

dynamic "ingress" {
    for_each = ["22", "80", "3000"]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id                   = aws_subnet.dev-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  key_name                    = local.key_name
  
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.web.public_ip
      
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.web.public_ip}, --private-key ${local.private_key_path} playbook.yaml"
  }
  depends_on = [aws_security_group.dev-sg]
}

