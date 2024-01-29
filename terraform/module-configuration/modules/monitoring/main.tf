resource "aws_instance" "monitoring_server" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
  tags = {
    Name        = var.vm_name
    environment = var.vm_environment
    role        = var.vm_role
  }
}