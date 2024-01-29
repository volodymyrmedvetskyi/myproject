terraform {
  backend "s3" {
    bucket         = "bucket-for-state2301"
    dynamodb_table = "table-for-state"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source              = "./modules/network"
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  a_z                 = var.a_z
}

module "security" {
  source        = "./modules/security"
  sg_name       = var.sg_name
  vpc_id        = module.network.vpc_id
  from_port_in  = var.from_port_in
  to_port_in    = var.to_port_in
  cidr_block_in = var.cidr_block_in
}

module "servers" {
  source         = "./modules/servers"
  vm_count = var.vm_count
  instance_type  = var.instance_type
  subnet_id      = module.network.public_subnet_ids[0]
  sg_id          = module.security.sg_id
  vm_name        = var.vm_name
  vm_environment = var.vm_environment
  vm_role        = var.vm_role
}

module "monitoring" {
  source         = "./modules/monitoring"
  instance_type  = var.instance_type
  subnet_id      = module.network.public_subnet_ids[1]
  sg_id          = module.security.sg_id
  vm_name        = var.monitoring_vm_name
  vm_environment = var.vm_environment
  vm_role        = var.monitoring_vm_role
}