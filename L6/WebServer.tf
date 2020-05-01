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

  resource "aws_eip" "my_static_ip" {
    instance = aws_instance.my_webserver.id
  }

resource "aws_instance" "my_webserver" {
    ami                    = "ami-0323c3dd2da7fb37d"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]
    user_data              = templatefile("user_data.sh.tpl", {
      f_name = "Janos",
      l_name = "Versler",
      names = ["John", "Donald", "Arnold", "Travis", "Denis", "Bob"]
      })

tags = {
  Name   = "Web Server built by terraform12"
  Owner  = "Janos Versler"
  }

lifecycle {
  create_before_destroy = true
  }
}



resource "aws_security_group" "my_webserver" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Janos Versler"
  }
}
