resource "aws_security_group" "allow-ssh-port_3000" {
  name        = "allow_ssh and port 3000 only"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.network.vpc_id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr_block]
  }


  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-SG.id]
  }


egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG2"
  }

}





