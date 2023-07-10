#Private routing table:
resource "aws_route_table" "priv_routing_table" {
  vpc_id = var.vpc-id-priv-subnet
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.r-nat-id
  }
  tags = {
    Name = var.name-priv-rt
  }
}

