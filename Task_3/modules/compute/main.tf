resource "aws_instance" "ec2" {
  count = var.instance_count
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = "${var.instance_name}-${count.index}",
    Env = var.env
  }
}