resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "private_rt"
  }
}


resource "aws_route_table_association" "private1_association" {
  subnet_id      = aws_subnet.subnets["private_subnet_1"].id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "private2_association" {
  subnet_id      = aws_subnet.subnets["private_subnet_2"].id
  route_table_id = aws_route_table.private_rt.id
}

