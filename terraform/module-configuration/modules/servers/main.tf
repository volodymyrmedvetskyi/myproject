resource "aws_instance" "ec2_instances" {
  count = var.vm_count
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
  tags = {
    Name        = var.vm_name[count.index]
    environment = var.vm_environment
    role        = var.vm_role[count.index]
  }
}