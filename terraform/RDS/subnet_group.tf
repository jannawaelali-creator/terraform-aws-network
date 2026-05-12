resource "aws_db_subnet_group" "Rds_subnet_group" {
  name       = "main_security_group"
  subnet_ids =  var.subnet_ids

  tags = {
    Name = "RDS_DB_subnet_group"
  }
}