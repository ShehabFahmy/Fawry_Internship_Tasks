module "network" {
  source              = "../../modules/network"
  env                 = var.env
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_names = var.public_subnet_names
  public_subnet_cidrs = var.public_subnet_cidrs
  igw_name            = var.igw_name
  pb_rtb_name         = var.pb_rtb_name
}

data "http" "my-public-ip" {
  url = "http://checkip.amazonaws.com"
}

module "secgrp" {
  source       = "../../modules/security_group"
  secgrp-name  = var.secgrp_name
  vpc-id       = module.network.vpc_id
  ingress-data = [{ from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["${trimspace(data.http.my-public-ip.response_body)}/32"], security_groups = [] }]
  egress-data  = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }]
}

module "key-pair" {
  source   = "../../modules/key_pair"
  key-name = var.key_pair_name
}

module "compute" {
  source                 = "../../modules/compute"
  env                    = var.env
  instance_count         = var.instance_count
  instance_name          = var.instance_name
  instance_ami           = var.instance_ami
  instance_type          = var.instance_type
  key_pair_name          = var.key_pair_name
  subnet_ids             = module.network.subnets_ids
  vpc_security_group_ids = [module.secgrp.id]
}