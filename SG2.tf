resource "aws_security_group" "allow-ssh-port_3000" {
  name        = "allow_ssh and port 3000 only "
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
    to_port     = 3000
    from_port   = 3000
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr_block]
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





