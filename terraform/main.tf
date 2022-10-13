module "vpc" {
  source = "./modules/vpc"
  vpc = {
    vpc_cidr = var.vpc["vpc_cidr"]
    public_subnet = var.vpc["public_subnet"]
    private_subnet = var.vpc["private_subnet"]
  }
  env = var.env
}