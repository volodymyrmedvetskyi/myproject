output "instance_ids" {
  value = [for id in aws_instance.ec2_instances : id.id]
}

output "public_addresses" {
  value = [for ip in aws_instance.ec2_instances : ip.public_ip]
}