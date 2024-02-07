data "aws_ami" "ubuntu" {
  filter {
    name   = "name"
    values = ["ubuntu-*"]
  }
  most_recent = true
}