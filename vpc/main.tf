module "vpc" {
  source = "./vpc"
  
  # Pass variables to the module
  vpc_name          = var.vpc_name
  cidr_block        = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  # Add more variables as needed
}
