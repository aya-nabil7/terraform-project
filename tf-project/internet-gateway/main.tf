resource "aws_internet_gateway" "IGW" {
  vpc_id = var.vpcID
  tags = {
    Name = var.IGW-name
  }
}