variable "your_region" {
  type        = string
  default     = "us-east-2"
  description = "Where you want your server to be. The options are here https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html."
}

variable "your_ami" {
  type        = string
  default     = "ami-0fae88c1e6794aa17"
  description = "Insert AMI for your instance. Please refer to default Amazon Linux AMIs for every region. Find your AMI here https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html"
}

variable "mojang_server_url" {
  type        = string
  default     = "https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar"
  description = "Copy the server download link from here https://www.minecraft.net/en-us/download/server/."
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  type    = string
  default = "Public_Key_Minecraft"
}

variable "project" {
  type    = string
  default = "Minecraft"
}
