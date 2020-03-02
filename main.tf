##################################################################################
# VARIABLES
##################################################################################
variable "key_name" {
  default = "narunas-keys"
}
##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region     = "us-west-2"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH on port 22 inbond"
 vpc_id = "${aws_default_vpc.default.id}"

  ingress {
      from_port = 22
     to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "centos-vm" {
  ami           = "ami-8b44f2f3"
  instance_type = "t2.micro"
  key_name        = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
    value = "${aws_instance.centos-vm.public_dns}"
}
