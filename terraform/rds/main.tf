resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds-subnet-elastic"
  subnet_ids = [var.public_subnet_id_in, var.private2_subnet_id_in]
}

resource "random_password" "password" {
  length  = 50
  special = false
}

resource "aws_db_instance" "rds" {
  // RDS Instance Identifier
  identifier = "elastic-identity"

  // Name of DB to create in RDS Instance
  name = "elastic_rds"

  username = var.username
  password = random_password.password.result

  // Default postgres port
  port = 5432

  engine         = "postgres"
  engine_version = "12.5"

  instance_class    = "db.t3.micro"
  allocated_storage = 5

  publicly_accessible  = true
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [var.sg_id_in]
}
