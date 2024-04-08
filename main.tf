# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create a security group for the instance
resource "aws_security_group" "instance_sg" {
  name = "game-server-sg"
  description = "Security group for game server"
  vpc_id = "vpc-091dc5ae016696f9e"	
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open SSH to the world (modify for security)
  }

  # Add more ingress rules for the game ports as needed
}

# Create the EC2 instance
resource "aws_instance" "clcm3506_server" {
  ami           = "ami-07ce5684ee3b5482c" # Replace with a suitable AMI ID
  instance_type = "t4g.nano"
  key_name      = "jenkinkeypair"
  subnet_id     = "subnet-0e43206888ecaae7c"

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  # Add tags to the instance
  tags = {
    Name = "Game Server"
	}
user_data     = <<-EOF
		#!/bin/bash
 		sudo yum update -y
 		sudo amazon-linux-extras install docker -y
 		sudo service docker start
 		sudo usermod -a -G docker ec2-user
 		sudo yum install -y python3
              EOF
}
