resource "aws_elasticache_subnet_group" "Reddis_subnet_group" {
  name       = "reddis-security-group"
  subnet_ids =  var.subnet_ids

  tags = {
    Name = "Reddis_subnet_group"
  }
}