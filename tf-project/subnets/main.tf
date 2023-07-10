#Public subnet:
resource "aws_subnet" "subnet" {
  vpc_id = var.vpc-id
  cidr_block = var.subnet_CIDR_Block
  availability_zone = var.az
  map_public_ip_on_launch = var.type-st
  tags = {
    Name = var.name
  }
}
