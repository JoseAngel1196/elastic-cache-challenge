module "rds" {
  source        = "./rds"
  identifier_in = "jose-rds-instance"
  name_in       = "jose-rds-elastic-challenge"
  access_key    = local.access_key
  secret_key    = local.secret_key
}

module "redis" {
  source        = "./redis"
  cluster_id_in = "cluster-elastic-challenge"
  access_key    = local.access_key
  secret_key    = local.secret_key
}
