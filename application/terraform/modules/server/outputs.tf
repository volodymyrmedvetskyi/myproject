output "instance_id_jenkins_server" {
  value = aws_instance.jenkins_server.id
}

output "public_address_jenkins_server" {
  value = aws_instance.jenkins_server.public_ip
}