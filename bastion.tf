
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = "t3.micro"
  subnet_id                   = module.network.subnets["public_subnet_1"].id
  vpc_security_group_ids      = [aws_security_group.allow-ssh.id]
  associate_public_ip_address = true      
  key_name                    = "terr"


provisioner "local-exec" {

  command     = "echo bastion IP is ${self.public_ip}"

}

  tags = {
    Name = "bastion"
  }
}


