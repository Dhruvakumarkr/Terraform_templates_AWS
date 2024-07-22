provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name      = "mo1"

  tags = {
    Name        = "WebServer"
    Description = "An Nginx Web server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
}
