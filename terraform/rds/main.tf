resource "random_password" "password" {
  length  = 50
  special = false
}

resource "aws_db_instance" "rds" {
  // RDS Instance Identifier
  identifier = "elastic-identity"

  // Name of DB to create in RDS Instance
  name = "elastic_rds"

  username = "jhidalgo"
  password = random_password.password.result

  // Default postgres port
  port = 5432

  engine         = "postgres"
  engine_version = "12.5"

  instance_class    = "db.t3.micro"
  allocated_storage = 5

  publicly_accessible = true
  skip_final_snapshot = true
}
