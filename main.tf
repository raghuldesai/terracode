provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terra-nginx"
    key    = "base-infra.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_instance" "k3s_node" {
  ami                    = "ami-0388e3ada3d9812da"
  instance_type          = "t3a.medium"
  key_name               = "k3key"
  subnet_id              = aws_subnet.k3s_subnet.id
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "k3s-node"
  }
}

output "k3s_node_ip" {
  value = aws_instance.k3s_node.public_ip
}
