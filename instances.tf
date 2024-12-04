resource "tls_private_key" "mc_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.mc_key.public_key_openssh
}

resource "aws_instance" "minecraft" {
  ami                         = var.your_ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated_key.key_name
  user_data                   = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo rpm --import https://yum.corretto.aws/corretto.key
    sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
    sudo yum install -y java-21-amazon-corretto-devel.x86_64
    wget -O server.jar ${var.mojang_server_url}
    java -Xmx1024M -Xms1024M -jar server.jar nogui
    sed -i 's/eula=false/eula=true/' eula.txt
    java -Xmx1024M -Xms1024M -jar server.jar nogui
    EOF
  tags = {
    Name   = var.project
    Backup = "true"
  }
}

resource "aws_ebs_volume" "mc_volume" {
  availability_zone = var.your_region
  size              = 8

  tags = {
    Name   = var.project
    Backup = "true"
  }
}

resource "aws_volume_attachment" "mc_volume_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.mc_volume.id
  instance_id = aws_instance.minecraft.id
}