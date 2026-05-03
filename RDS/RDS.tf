resource "aws_db_instance" "myinstance" {
  engine               = "mysql"
  identifier           = "myrdsinstance"
  allocated_storage    =  20
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "myrdsuser"
  password             = "myrdspassword"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.Rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_security_group.id]
  skip_final_snapshot  = true
  publicly_accessible =  false
}
