provider "aws" {
    region = "us-east-2"    
}

resource "aws" "instance" "my-instance" {
    ami = ""
    key_name = ""
    instance_type = "t2.micro "
    vpc_security_group_ids = "[aws_security_group.my-sg.id]"
} 


resource "aws_security_group" "my-sg" {
  name        = "all-allow_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "my-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = ["0.0.0.0/0"]
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
