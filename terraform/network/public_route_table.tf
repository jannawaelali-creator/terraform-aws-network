resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}


resource "aws_route_table_association" "public1_association" {
  subnet_id      = aws_subnet.subnets["public_subnet_1"].id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "public2_association" {
  subnet_id      = aws_subnet.subnets["public_subnet_2"].id
  route_table_id = aws_route_table.public_rt.id
}

