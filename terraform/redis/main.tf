resource "aws_elasticache_subnet_group" "cluster_subnet" {
  name       = "redis-cluster"
  subnet_ids = ["subnet-090dcea4bcccc5dc0", "subnet-0887cd36d76729397"]
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "elastic-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = 6379
  availability_zone    = "us-east-1a"
  subnet_group_name    = aws_elasticache_subnet_group.cluster_subnet.name
  security_group_ids   = ["sg-09e0da3cdecee0755"]
}
