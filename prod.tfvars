region= "us-east-1"
vpc_cidr= "10.0.0.0/16"

subnet_map=[
{  name="public_subnet_1"
   cidr= "10.0.1.0/24"
   type= "public"
    az= "us-east-1a"

},
{
 name="public_subnet_2"
   cidr= "10.0.2.0/24"
   type= "public"
    az= "us-east-1b"
},
{
  name="private_subnet_1"
   cidr= "10.0.3.0/24"
   type= "private"
    az= "us-east-1a"
},

{
   name="private_subnet_2"
   cidr= "10.0.4.0/24"
   type= "private"
    az= "us-east-1b"
}
]

ami= "ami-0c02fb55956c7d316"

