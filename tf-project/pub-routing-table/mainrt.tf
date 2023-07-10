#Public routing table:
resource "aws_route_table" "pub_routing_table" {
  vpc_id = var.vpc-id-pub-subnet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.prt-gw-id
  }
  tags = {
    Name = var.name-pub-rt
  }
}


