resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.namespace}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.namespace}-gw"
  }
}

resource "aws_subnet" "public" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"

  tags = {
    Name = "${var.namespace}-Public"
  }
}

resource "aws_subnet" "private1" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "${var.namespace}-Private1"
  }
}

resource "aws_subnet" "private2" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "${var.namespace}-Private2"
  }
}

resource "aws_network_acl" "public_acl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public.id]
  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 104
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  tags = {
    Name = "${var.namespace}-public-acl"
  }
}

resource "aws_network_acl" "private_acl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  tags = {
    Name = "${var.namespace}-private-acl"
  }
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "54.146.46.232"
  type       = "ipsec.1"

  tags = {
    Name = "${var.namespace}-customer-gateway"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.namespace}/PublicRouteTable"
  }
}

resource "aws_route" "public_subnet" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
  route_table_id         = aws_route_table.public.id
}

resource "aws_route_table_association" "public_us_east_1a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "sg" {
  description = "Enable access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-sg"
  }
}
