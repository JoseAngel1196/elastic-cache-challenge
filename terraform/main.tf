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
  source           = "./server"
  access_key       = local.access_key
  secret_key       = local.secret_key
  namespace        = var.namespace
  public_subnet_id = local.public_subnet_id
  key_name         = module.ssh.key_name
}

module "redis" {
  source     = "./redis"
  namespace  = var.namespace
  access_key = local.access_key
  secret_key = local.secret_key
}

module "rds" {
  source     = "./rds"
  access_key = local.access_key
  secret_key = local.secret_key
  namespace  = var.namespace
}

