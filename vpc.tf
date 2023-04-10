module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnets  = ["10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  create_database_subnet_group = true
  create_database_subnet_route_table = true
  

 #NAT Gateway for private subnet-Outbound COmmunication

  enable_nat_gateway = true
  single_nat_gateway = true


#VPC DNS Parameters
enable_dns_hostnames= true
enable_dns_support = true

public_subnet_tags = {
    Type = "public-subnets"
  }


private_subnet_tags = {
    name = "Private-subnet"
}

database_subnet_tags = {
    name= "database-subnet"
}


  tags = {
    Name = "3tier"
  }
}
