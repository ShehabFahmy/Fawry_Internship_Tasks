output "instances_ids" {
  value = [for i in aws_instance.ec2 : i.id]
}

output "instances_public_ips" {
  value = [for i in aws_instance.ec2 : i.public_ip]
}

output "instances_private_ips" {
  value = [for i in aws_instance.ec2 : i.private_ip]
}