# Configure AWS Provider
provider "aws" {
    region  = var.region
}

# Create VPC
module "vpc" {
    source                       = "../modules/vpc"
    region                       = var.region
    project_name                 = var.project_name
    vpc_cidr                     = var.vpc_cidr
    public_subnet_az1_cidr       = var.public_subnet_az1_cidr
    public_subnet_az2_cidr       = var.public_subnet_az2_cidr
    private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
    private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
    private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

# Create nat-gateway
module "nat_gateway" {
    source                       = "../modules/nat-gateway"
    public_subnet_az1_id         = module.vpc.public_subnet_az1_id
    internet_gateway             = module.vpc.internet_gateway
    public_subnet_az2_id         = module.vpc.public_subnet_az2_id
    vpc_id                       = module.vpc.vpc_id
    private_app_subnet_az1_id    = module.vpc.private_app_subnet_az1_id
    private_app_subnet_az2_id    = module.vpc.private_app_subnet_az2_id
    private_data_subnet_az1_id   = module.vpc.private_data_subnet_az1_id
    private_data_subnet_az2_id   = module.vpc.private_data_subnet_az2_id
}

# Create Security Group
module "security_group" {
    source                       = "../modules/security-groups"
    vpc_id                       = module.vpc.vpc_id
}

# Create Instance
module "ec2_instance" {
    source                = "../modules/ec2"
    ami_id                = var.ami_id
    instance_type         = var.instance_type
    key_name              = var.key_name
    public_subnet_az1_id         = module.vpc.public_subnet_az1_id
    # public_subnet_az2_id         = module.vpc.public_subnet_az2_id
}