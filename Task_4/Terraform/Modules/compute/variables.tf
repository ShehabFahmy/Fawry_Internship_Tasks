variable "instance_name" {
  type = string
}

variable "instance_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "key_pair_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "env" {
  type = string
}