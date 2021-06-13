resource "random_password" "password" {
  length  = 50
  special = false
}

resource "aws_db_instance" "rds" {
  // RDS Instance Identifier
  identifier = "jose-rds-instance"

  // Name of DB to create in RDS Instance
  name = "elastic_challenge"

  username = "jose"
  password = random_password.password.result

  // Default postgres port
  port = 5432

  engine         = "postgres"
  engine_version = "12.5"

  instance_class    = var.instance_class
  allocated_storage = 5

  publicly_accessible = true
  skip_final_snapshot = true
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "cluster-elastic-challenge"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  port                 = 6379
}