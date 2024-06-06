provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "value"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}
#now call for module
module "vpc_module" {
    source = "./module/vpc"   #path main.tf directory
    vpc_cidr = "10.10.0.0/16"
    project = "main"
    env = "dev"
    private_subnet_cidr = "10.10.0.0/20"
    public_subnet_cidr = "10.10.16.0/20"
}