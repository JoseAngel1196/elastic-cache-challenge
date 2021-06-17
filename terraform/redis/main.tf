resource "aws_elasticache_subnet_group" "cluster_subnet" {
  name       = "redis-cluster"
  subnet_ids = [var.public_subnet_id_in, var.private1_subnet_id_in]
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "elastic-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = 6379
  availability_zone    = var.region_in
  subnet_group_name    = aws_elasticache_subnet_group.cluster_subnet.name
  security_group_ids   = [var.sg_id_in]
}
