resource "aws_instance" "application_server" {
  #  ami             = data.aws_ami.ubuntu.id
  ami             = "ami-0c7217cdde317cfec"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
  key_name        = "my-application-key-pair"
  tags = {
    Name        = var.vm_name
    environment = var.vm_environment
    role        = var.vm_role
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-application-key-pair"
  public_key = file("my-key-pair.pub")
}