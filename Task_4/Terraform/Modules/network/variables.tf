variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "env" {
  type = string
}

variable "public_subnet_names" {
  type    = list(string)
}

variable "public_subnet_cidrs" {
  type    = list(string)
}

variable "igw_name" {
  type = string
}

variable "pb_rtb_name" {
  type = string
}