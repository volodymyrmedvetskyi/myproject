output "instance_id_monitoring_server" {
  value = aws_instance.monitoring_server.id
}

output "public_address_monitoring_server" {
  value = aws_instance.monitoring_server.public_ip
}