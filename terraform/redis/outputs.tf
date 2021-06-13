output "endpoint_redis" {
  value = join(":", [aws_elasticache_cluster.redis.cache_nodes[0].address, aws_elasticache_cluster.redis.port])
}
