module "network" {
    source= "./network"
    subnet_map=var.subnet_map
    vpc_cidr=var.vpc_cidr

}


module "RDS" {
    source= "./RDS"
    subnet_ids=[module.network.subnets["private_subnet_1"].id,
    module.network.subnets["private_subnet_2"].id      ]
    vpc_cidr=module.network.vpc_cidr_block
    vpc_id=module.network.vpc_id

}

module "reddis" {
    source= "./redis"
    subnet_ids=[module.network.subnets["private_subnet_1"].id,
    module.network.subnets["private_subnet_2"].id      ]
    vpc_cidr=module.network.vpc_cidr_block
    vpc_id=module.network.vpc_id

}