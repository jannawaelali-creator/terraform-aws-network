
resource "aws_instance" "app" {
  ami                         = var.ami
  instance_type               = "t3.micro"
  subnet_id                   = module.network.subnets["private_subnet_1"].id
  vpc_security_group_ids      = [aws_security_group.allow-ssh-port_3000.id]
  associate_public_ip_address = false      
  key_name                    = "terr-new"

  tags = {
    Name = "app"
  }
} 