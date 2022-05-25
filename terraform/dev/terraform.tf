locals {
  ssh_user         = "ubuntu"
  key_name         = "ansible-da"
  private_key_path = "~/.ssh/ansible-da.pem"
  playbook_path    = "~/edu-repo/terraform/dev/playbook.yaml"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["086913749727"]
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
    command = "ansible-playbook -i ${aws_instance.web.public_ip}, --private-key ${local.private_key_path} ${local.playbook_path}"
  }
  depends_on = [aws_security_group.dev-sg]
}

