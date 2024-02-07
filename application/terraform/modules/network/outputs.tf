output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.my_public_subnet : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.my_private_subnet : subnet.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_internet_gateway.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.my_nat_gateway.id
}

output "eip_address" {
  value = aws_eip.my_eip.address
}