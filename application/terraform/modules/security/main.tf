resource "aws_security_group" "my_security_group" {
  name        = var.sg_name
  description = "Inbound and outbound rules"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ports_in
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_block_in
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg_name
  }
}