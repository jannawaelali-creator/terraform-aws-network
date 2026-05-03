module "network" {
    source= "./network"
    subnet_map=var.subnet_map
    vpc_cidr=var.vpc_cidr

}