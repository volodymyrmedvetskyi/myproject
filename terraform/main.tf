provider "aws" {
  region = var.region
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "my-public-subnet"
  }
}

resource "aws_subnet" "my_private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "my-private-subnet"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
  tags = {
    Name = "my-public-route-table"
  }
}

resource "aws_route_table_association" "my_public_subnet_association" {
  route_table_id = aws_route_table.my_public_route_table.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_security_group" "my_security_group" {
  name   = "my-security-group"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "my-security-group"
  }
}

resource "aws_instance" "jenkins_controller" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  tags = {
    Name        = "jenkins-controller"
    environment = "prod"
    role        = "jenkins"
  }
}

resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  tags = {
    Name        = "app-server"
    environment = "prod"
    role        = "application"
  }
}