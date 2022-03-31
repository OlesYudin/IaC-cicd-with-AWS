locals {
    # -----------
    # VPC
    # -----------
    # Default VPC CIDR
    cidr_vpc = "172.31.0.0/16" 
    # Default public subnets for VPC
    public_subnet = ["172.31.3.0/24", "172.31.4.0/24"]
    # Default private subnets for VPC
    private_subnet = ["172.31.13.0/24", "172.31.14.0/24"]
    # Default CIDR for routing traffic
    default_cidr = "0.0.0.0/0"
}