
resource "aws_key_pair" "key" {
  key_name   = "${var.namespace}-key"
  public_key = var.public_key
}
