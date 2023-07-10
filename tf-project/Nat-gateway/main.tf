#EIP
resource "aws_eip" "EIP" {
  vpc = true
}

#Nat gateway
resource "aws_nat_gateway" "NAT-GW" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = var.sub-id
  tags = {
    Name = "pro-Nat-GW"
}
} 