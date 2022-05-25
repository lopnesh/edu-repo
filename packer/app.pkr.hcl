packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.9"
      source = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {
  type = string
  default = "secret.aws_access_key"
}

// export PKR_VAR_aws_secret_key=$YOURSECRETKEY
variable "aws_secret_key" {
  type = string
  default = "aws_secret_key"
}

source "amazon-ebs" "basic-example" {
  access_key = var.aws_access_key
  secret_key =  var.aws_secret_key
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