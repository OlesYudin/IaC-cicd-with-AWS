locals {
    # -----------
    # VPC
    # -----------
    # Default VPC CIDR
    cidr_vpc = "172.31.0.0/16" 
    # Default public subnets for VPC
    public_subnet = ["172.31.1.0/24", "172.31.2.0/24"]
    # Default private subnets for VPC
    private_subnet = ["172.31.11.0/24", "172.31.12.0/24"]
    # Default CIDR for routing traffic
    default_cidr = "0.0.0.0/0"
}