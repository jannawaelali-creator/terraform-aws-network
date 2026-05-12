resource "aws_security_group" "RDS_security_group" {
  name        = "RDS_security_group"
  description = "Allow TLS inbound traffic traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
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
    Name = "RDS_security_group"
  }

}





