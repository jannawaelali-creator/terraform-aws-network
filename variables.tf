variable "vpc_cidr" {
  type    = string
  
}

variable "subnet_map"{
    type=list(object ( {
        name=string,
        cidr=string,
        type=string,
        az=string


    }))

}


variable "region" {
  type    = string
  
}

variable "ami" {
  type    = string
  
}


