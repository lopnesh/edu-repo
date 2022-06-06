# Create a new load balancer
resource "aws_elb" "jager-elb" {
  name               = "jager-terraform-elb"
  subnets = [aws_subnet.dev-subnet-1.id, aws_subnet.dev-subnet-2.id]
  security_groups    = [aws_security_group.dev-sg.id]

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:3000/"
    interval            = 30
  }

  instances                   = [aws_instance.web-1.id, aws_instance.web-2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "jager-terraform-elb"
  }
}
