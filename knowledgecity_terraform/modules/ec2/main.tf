resource "aws_instance" "private_ec2" {
  count             = length(var.private_subnet_ids)
  ami               = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.private_subnet_ids[count.index]
  associate_public_ip_address = false

  tags = {
    Name = "private-monolith-PHP-EC2-${count.index + 1}"
  }
}
