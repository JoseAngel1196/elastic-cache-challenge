module "elastic_server" {
  source     = "./elastic_server"
  access_key = local.access_key
  secret_key = local.secret_key
  public_key = local.public_key
}

module "rds" {
  source        = "./rds"
  identifier_in = "jose-rds-instance"
  name_in       = "jose_rds_elastic_challenge"
  access_key    = local.access_key
  secret_key    = local.secret_key
}

module "redis" {
  source        = "./redis"
  cluster_id_in = "cluster-elastic-challenge"
  access_key    = local.access_key
  secret_key    = local.secret_key
}
