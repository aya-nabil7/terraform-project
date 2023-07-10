# association subnet with routing table
resource "aws_route_table_association" "asso-rt-sub" {
  subnet_id      = var.ass-sub-id
  route_table_id = var.ass-rt-id
}
