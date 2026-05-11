resource "aws_security_group" "alb-SG" {
  name        = "alb-SG"
  description = "Allow alb inbound traffic and all outbound traffic"
  vpc_id      = module.network.vpc_id


  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_SG"
  }

}





