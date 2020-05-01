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

  resource "aws_instance" "my_webserver" {
      ami                    = "ami-0323c3dd2da7fb37d"
      instance_type          = "t2.micro"
      vpc_security_group_ids = [aws_security_group.my_webserver.id]
      user_data              = templatefile("user_data.sh.tpl", {
        f_name = "Janos",
        l_name = "Versler",
        names = ["John", "Donald", "Arnold", "Travis", "Denis"]
        })

  tags = {
    Name   = "Web Server built by terraform12"
    Owner  = "Janos Versler"
    }
  }

resource "aws_security_group" "my_webserver" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"


dynamic "ingress" {
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
