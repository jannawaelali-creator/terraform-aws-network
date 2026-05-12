resource "aws_security_group" "allow-ssh" {
  name        = "allow_ssh"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.network.vpc_id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "SG1"
  }

}





