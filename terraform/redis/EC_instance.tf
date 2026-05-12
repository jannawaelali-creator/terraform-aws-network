resource "aws_elasticache_cluster" "my_redis" {
  cluster_id           = "my-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  
 
  subnet_group_name    = aws_elasticache_subnet_group.Reddis_subnet_group.name
  security_group_ids   = [aws_security_group.Reddis_security_group.id]
}