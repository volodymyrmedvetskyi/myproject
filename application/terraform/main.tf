provider "aws" {
  region = var.region
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
  ports_in      = var.ports_in
  cidr_block_in = var.cidr_block_in
}

module "server" {
  source         = "./modules/server"
  instance_type  = var.instance_type
  subnet_id      = module.network.public_subnet_ids[0]
  sg_id          = module.security.sg_id
  vm_name        = var.vm_name
  vm_environment = var.vm_environment
  vm_role        = var.vm_role
}