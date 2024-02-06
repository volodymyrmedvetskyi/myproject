resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my_public_subnet" {
  for_each                = { for i, block in var.public_subnet_cidr : i + 1 => block }
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = each.value
  availability_zone       = var.a_z[each.key - 1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "my_private_subnet" {
  for_each          = { for i, block in var.private_subnet_cidr : i + 1 => block }
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = each.value
  availability_zone = var.a_z[each.key - 1]
  tags = {
    Name = "${var.vpc_name}-private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_eip" "my_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_nat_gateway" {
  subnet_id     = values(aws_subnet.my_private_subnet)[0].id
  allocation_id = aws_eip.my_eip.id
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table_association" "my_public_subnet_association" {
  for_each       = aws_subnet.my_public_subnet
  route_table_id = aws_route_table.my_public_route_table.id
  subnet_id      = each.value.id
}

resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "my_private_subnet_association" {
  for_each       = aws_subnet.my_private_subnet
  route_table_id = aws_route_table.my_private_route_table.id
  subnet_id      = each.value.id
}