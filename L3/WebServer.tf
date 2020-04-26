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
    user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform12!"  >  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

tags = {
  Name   = "Web Server built by terraform12"
  Owner  = "Janos Versler"
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
