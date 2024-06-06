provider "aws" "instance" {
  region = "us-east-2"
  access_key = "AKIA3FLD6PNQOIR7NTTT"
  secret_key = "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"
}
resource "aws-instance" "ins-1" {
    ami = "ami-0ca2e925753ca2fb4"
    instance_type = "t2.micro"
    key_name = "key"
}