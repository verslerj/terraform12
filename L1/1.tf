provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-068663a3c619dd892"
    instance_type = "t2.micro"
}
