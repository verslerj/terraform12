#---------------------------------------------
# My Terraform
#
# Build WebServer during bootstrap
#
# Made by Janos Versler
#---------------------------------------------


provider "aws" {
    region        = "us-east-1"
  }


resource "aws_security_group" "my_webserver" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"


dynamic "ingress": {
  for_each = ["80", "443", "1541", "9092"]
content {
  from_port = ingress.value
  to_port = ingress.value
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Janos Versler"
  }
}
