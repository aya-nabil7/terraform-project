#VPC:
resource "aws_vpc" "vpc-project" {
  cidr_block = var.VPC_CIDR_Block
  tags = {
    Name = "vpc-project-ayan"
  }
}