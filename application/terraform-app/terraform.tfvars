region = "us-east-1"

vpc_name            = "my-application-vpc"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
a_z                 = ["us-east-1a", "us-east-1b"]

sg_name       = "my-application-security-group"
ports_in      = [22, 8080, 3000]
cidr_block_in = ["0.0.0.0/0"]

instance_type  = "t2.small"
vm_name        = "app-server"
vm_environment = "prod"
vm_role        = "application"