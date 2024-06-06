resource "aws_vpc" "main-vpc" {
  cidr_block = "var.vpc_cidr"
  tags = {
    Name = "$(var.project).vpc"
    Env = var.env
   }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "var.private_subnet_cidr"
  tags = {
    Name = "$(var.project)-private-sub"
    Env = var.env
  }
} 

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "var.public_subnet_cidr"
  map_public_ip_on_launch = true
  tags = {
    Name = "$(var.project)-public-sub"
    Env = var.env
  }
} 

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "${var.project}-igw"
        env = var.env
    }
  
}
resource "aws_default_route_table" "main_default_route_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "rt"
    env = var.env
  }
}

