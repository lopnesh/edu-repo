locals {
  ssh_user         = "ubuntu"
  key_name         = "ansible-da"
  private_key_path = "~/.ssh/ansible-da.pem"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["086913749727"]
}

resource "aws_instance" "web-1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id                   = aws_subnet.dev-subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  key_name                    = local.key_name

  depends_on = [aws_db_instance.mydb, aws_db_subnet_group.default]
  }

resource "aws_instance" "web-2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id                   = aws_subnet.dev-subnet-2 .id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  key_name                    = local.key_name

  depends_on = [aws_db_instance.mydb, aws_db_subnet_group.default]
  }
