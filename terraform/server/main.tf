resource "aws_network_interface" "interface" {
  subnet_id       = var.public_subnet_id_in
  security_groups = [var.sg_id_in]

  tags = {
    Name = "${var.namespace}-interface"
  }
}


resource "aws_instance" "server" {
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"
  key_name      = var.key_name_in

  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }

  tags = {
    "Name" = "${var.namespace}-ec2"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.server.id
  vpc      = true
}
