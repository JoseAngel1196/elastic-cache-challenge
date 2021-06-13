resource "aws_key_pair" "elastic_key" {
  key_name   = var.key_name
  public_key = var.public_key
}


resource "aws_instance" "elastic_server" {
  ami                         = "ami-0be2609ba883822ec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.elastic_key.key_name
  associate_public_ip_address = true
}

resource "aws_security_group" "redis_sg" {
  name        = "redis_sg"
  description = "Security group to connect to Redis"
}

resource "aws_security_group_rule" "redis_rule_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.redis_sg.id
}
