# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block         = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Use data source to get list of availability zones in region
data "aws_availability_zones" "available_zones" {}

# Create Public Subnets az1
resource "aws_subnet" "public_subnet_az1" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az1"
  }
}

# Create Public Subnets az2
resource "aws_subnet" "public_subnet_az2" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az2"
  }
}

# Create Route Table and Add Public Route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate Public Subnet az1 to "Public Route Table"
resource "aws_route_table_association" "public_subnet_az1_rt_association" {
    subnet_id = aws_subnet.public_subnet_az1.id
    route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Subnet az2 to "Public Route Table"
resource "aws_route_table_association" "public_subnet_az2_rt_association" {
    subnet_id = aws_subnet.public_subnet_az2.id
    route_table_id = aws_route_table.public_route_table.id
}

# Create Private App Subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.private_app_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-app-subnet-az1"
  }
}

# Create Private App Subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.private_app_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-app-subnet-az2"
  }
}

# Create Private Data Subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.private_data_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-data-subnet-az1"
  }
}

# Create Private Data Subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
    vpc_id                = aws_vpc.vpc.id 
  cidr_block              = var.private_data_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-data-subnet-az2"
  }
}