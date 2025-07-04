env                 = "pre-prod"
vpc_name            = "poc-pre-prod-vpc"
vpc_cidr            = "10.0.0.0/16"
public_subnet_names = ["poc-pre-prod-subnet1"]
public_subnet_cidrs = ["10.0.1.0/24"]
igw_name            = "poc-pre-prod-igw"
pb_rtb_name         = "poc-pre-prod-rtb"

secgrp_name    = "poc-pre-prod-secgrp"
key_pair_name  = "poc-pre-prod-keypair"
instance_name  = "poc-pre-prod-instance"
instance_ami   = "ami-0731becbf832f281e"
instance_type  = "t2.micro"
instance_count = 1
