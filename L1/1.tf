provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-068663a3c619dd892"
    instance_type = "t2.micro"
    tags = {
      Name = "UbuntuSrv"
      Owner = "Janos Versler"
      Project = "terraform12"
    }
}

resource "aws_instance" "amazon_linux" {
    ami = "ami-0323c3dd2da7fb37d"
    instance_type = "t2.micro"
    tags = {
      Name = "AmazonLinuxSrv"
      Owner = "Janos Versler"
      Project = "terraform12"
    }
}
