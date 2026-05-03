output "subnets"{
    value = aws_subnet.subnets
}

output "vpc_cidr_block"{
    value = aws_vpc.myvpc.cidr_block
}

output "vpc_id"{
    value = aws_vpc.myvpc.id
}