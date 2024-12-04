resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_subnet_az1" {
  availability_zone = "${var.aws_region}a"
}

resource "aws_subnet" "default_subnet_az2" {
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.aws_region}b"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_subnet" "default_subnet_az3" {
  cidr_block = "192.168.0.0/24"
  availability_zone = "${var.aws_region}c"
  vpc_id = aws_default_vpc.default.id

}

resource "aws_security_group" "allow_minecraft_server_port" {
  name        = "minecraft_server_port"
  description = "Allow inbound traffic to the Minecraft server port"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "Minecraft server port"
    from_port        = 25565
    to_port          = 25565
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "EFS NFS port"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.common_tags
}