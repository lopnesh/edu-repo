resource "aws_vpc" "prod" {
  cidr_block = "10.10.11.0/24"
}

resource "aws_security_group" "prod-sg" {
  name   = "prod-sg"
  vpc_id = aws_vpc.prod.id

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