env                 = "prod"
vpc_name            = "poc-prod-vpc"
vpc_cidr            = "10.0.0.0/16"
public_subnet_names = ["poc-prod-subnet1", "poc-prod-subnet2"]
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
igw_name            = "poc-prod-igw"
pb_rtb_name         = "poc-prod-rtb"

secgrp_name    = "poc-prod-secgrp"
key_pair_name  = "poc-prod-keypair"
instance_name  = "poc-prod-instance"
instance_ami   = "ami-0731becbf832f281e"
instance_type  = "t3a.small"
instance_count = 2

logs_bucket_name          = "poc-prod-vpc-flow-logs-bucket"
cloudwatch_log_group_name = "/aws/vpc/poc-prod-logs"

ecr-name = "poc-prod-ecr"