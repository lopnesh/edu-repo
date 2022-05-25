packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.9"
      source = "github.com/hashicorp/amazon"
    }
  }
}

{
  "variables": {
    "access_key": "{{env `AWS_ACCESS_KEY_ID`}}"
    "secret_key": "{{env `AWS_SECRET_ACCESS_KEY`}}"
  }
}

source "amazon-ebs" "basic-example" {
  access_key = var.access_key
  secret_key =  var.secret_key
  region =  "eu-central-1"
  source_ami =  "ami-015c25ad8763b2f11"
  instance_type =  "t2.micro"
  ssh_username =  "ubuntu"
  ami_name =  "packer_AWS {{timestamp}}"
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]
  provisioner "ansible" {
      playbook_file = "./ansible/playbook.yaml"
      user            = "ubuntu"
      use_proxy       = false
      }
}