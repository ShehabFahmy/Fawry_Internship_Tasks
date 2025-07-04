output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets_ids" {
  value = [for s in aws_subnet.subnets : s.id]
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "rtb_id" {
  value = aws_route_table.pb-rtb.id
}

output "rtb-assoc-ids" {
  value = [for assoc in aws_route_table_association.public-associations : assoc.id]
}