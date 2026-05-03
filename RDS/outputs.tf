
output "rds_endpoint" {
  value       = aws_db_instance.myinstance.endpoint
  description = "The connection endpoint for the RDS instance"
}


output "db_name" {
  value       = aws_db_instance.myinstance.db_name
  description = "The name of the database created"
}

    
output "rds_sg_id" {
  value       = aws_security_group.RDS_security_group.id
  description = "The ID of the security group used by RDS"
}