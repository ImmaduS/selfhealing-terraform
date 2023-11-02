resource "aws_vpc" "vpc_name" {
  
  tags = {
    Name =var.vpc_name}
}