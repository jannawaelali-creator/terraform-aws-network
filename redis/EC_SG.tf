resource "aws_security_group" "Reddis_security_group" {
  name        = "Reddis-security-group"
  description = "Allow TLS inbound traffic traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "reddis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Reddis_security_group"
  }

}





