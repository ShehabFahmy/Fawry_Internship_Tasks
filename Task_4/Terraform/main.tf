module "network" {
  source              = "./Modules/network"
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
  source      = "./Modules/security_group"
  secgrp-name = var.secgrp_name
  vpc-id      = module.network.vpc_id
  ingress-data = [{ from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["${trimspace(data.http.my-public-ip.response_body)}/32"], security_groups = [] },
    { from_port = 30080, to_port = 30080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], security_groups = [] },
    # TCP 6443: K3s API Server (used by agents to connect to server)
    { from_port = 6443, to_port = 6443, protocol = "tcp", cidr_blocks = ["${var.vpc_cidr}"], security_groups = [] },
    { from_port = 6443, to_port = 6443, protocol = "tcp", cidr_blocks = ["${trimspace(data.http.my-public-ip.response_body)}/32"], security_groups = [] },
    # UDP 8472: Flannel VXLAN (networking)
    { from_port = 8472, to_port = 8472, protocol = "udp", cidr_blocks = ["${var.vpc_cidr}"], security_groups = [] },
    # TCP 10250: Kubelet API (for metrics/logs)
    { from_port = 10250, to_port = 10250, protocol = "tcp", cidr_blocks = ["${var.vpc_cidr}"], security_groups = [] }
  ]
  egress-data = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }]
}

module "key-pair" {
  source   = "./Modules/key_pair"
  key-name = var.key_pair_name
}

module "compute" {
  source                 = "./Modules/compute"
  env                    = var.env
  instance_count         = var.instance_count
  instance_name          = var.instance_name
  instance_ami           = var.instance_ami
  instance_type          = var.instance_type
  key_pair_name          = var.key_pair_name
  subnet_ids             = module.network.subnets_ids
  vpc_security_group_ids = [module.secgrp.id]
}

# module "logging" {
#   source                    = "./Modules/logging"
#   env                       = var.env
#   logs_bucket_name          = var.logs_bucket_name
#   cloudwatch_log_group_name = var.cloudwatch_log_group_name
#   vpc_id                    = module.network.vpc_id
# }

module "ecr" {
  source = "./Modules/ecr"
  name   = var.ecr-name
}
