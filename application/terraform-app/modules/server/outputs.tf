output "instance_id_application_server" {
  value = aws_instance.application_server.id
}

output "public_address_application_server" {
  value = aws_instance.application_server.public_ip
}