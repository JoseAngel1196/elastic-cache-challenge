resource "random_string" "username" {
  length  = 10
  special = false
}

resource "random_password" "password" {
  length  = 50
  special = false
}

resource "aws_db_instance" "rds" {
  // RDS Instance Identifier
  identifier = var.identifier_in

  // Name of DB to create in RDS Instance
  name = var.name_in

  username = random_string.username.result
  password = random_password.password.result

  // Default postgres port
  port = 5432

  engine         = "postgres"
  engine_version = "12.5"

  instance_class    = "db.m6g.large"
  allocated_storage = 5

  publicly_accessible = true
  skip_final_snapshot = true
}
