module "networking" {
  source     = "./networking"
  namespace  = var.namespace
  access_key = local.access_key
  secret_key = local.secret_key
}

module "ssh" {
  source     = "./ssh"
  namespace  = var.namespace
  public_key = local.public_key
  access_key = local.access_key
  secret_key = local.secret_key
}

module "server" {
  source     = "./server"
  access_key = local.access_key
  secret_key = local.secret_key
  namespace  = var.namespace
  sg_id_in   = module.networking.sg_id
}

module "redis" {
  source                = "./redis"
  namespace             = var.namespace
  access_key            = local.access_key
  secret_key            = local.secret_key
  public_subnet_id_in   = module.networking.public_subnet_id
  private1_subnet_id_in = module.networking.private1_subnet_id
  region_in             = var.region
  sg_id_in              = module.networking.sg_id
}

module "rds" {
  source                = "./rds"
  access_key            = local.access_key
  secret_key            = local.secret_key
  namespace             = var.namespace
  public_subnet_id_in   = module.networking.public_subnet_id
  private1_subnet_id_in = module.networking.private1_subnet_id
}

