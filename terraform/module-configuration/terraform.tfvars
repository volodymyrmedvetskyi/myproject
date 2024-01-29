vpc_name            = "my-vpc"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
a_z                 = ["us-east-1a", "us-east-1b"]

sg_name       = "my-security-group"
from_port_in  = 22
to_port_in    = 22
cidr_block_in = ["0.0.0.0/0"]

vm_count = 2

instance_type  = "t2.micro"
vm_name        = ["jenkins-controller", "app-server"]
vm_environment = "prod"
vm_role        = ["jenkins", "application"]

monitoring_vm_name = "monitoring-server"
monitoring_vm_role = "monitoring"