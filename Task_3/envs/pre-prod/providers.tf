provider "aws" {
  # profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket       = "poc-statefile-bucket"
    key          = "pre-prod/statefile/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true #S3 native locking
  }
}
