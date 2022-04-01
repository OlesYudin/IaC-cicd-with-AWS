locals {
    # -----------
    # VPC
    # -----------
    # Default VPC CIDR
    cidr_vpc = "172.30.0.0/16" 
    # Default public subnets for VPC
    public_subnet = ["172.30.1.0/24", "172.30.2.0/24"]
    # Default private subnets for VPC
    private_subnet = ["172.30.11.0/24", "172.30.12.0/24"]
    # Default CIDR for routing traffic
    default_cidr = "0.0.0.0/0"
}