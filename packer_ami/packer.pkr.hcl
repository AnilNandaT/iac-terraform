variable "vpn_source_ami" {
  type    = string
  default = "ami-047627086234fbbe7"
}

variable "sonarqube_source_ami" {
  type    = string
  default = "ami-0cff7528ff583bf9a"
}

source "amazon-ebs" "vpn" {
  ami_name              = "vpn"
  instance_type         = "t2.small"
  region                = "us-east-1"
  source_ami            = var.vpn_source_ami
  force_deregister      = true
  subnet_id = "subnet-0a63f0601ff772f2b"
  vpc_id = "vpc-0b63f5bfaab2a1209"
  force_delete_snapshot = true
  ssh_username          = "ec2-user"
  tags = {
    "Name" = "vpn"
  }
  launch_block_device_mappings {
      device_name = "/dev/sda1"
      volume_type = "gp2"
      volume_size = 30
      delete_on_termination = true
    }
}

source "amazon-ebs" "sonarqube" {
  ami_name              = "sonarqube"
  instance_type         = "t2.small"
  region                = "us-east-1"
  source_ami            = var.sonarqube_source_ami
  force_deregister      = true
  subnet_id = "subnet-0a63f0601ff772f2b"
  vpc_id = "vpc-0b63f5bfaab2a1209"
  iam_instance_profile = "packer_role"
  force_delete_snapshot = true
  ssh_username          = "ec2-user"
  tags = {
    "Name" = "sonarqube"
  }
  launch_block_device_mappings {
      device_name = "/dev/xvda"
      volume_type = "gp2"
      volume_size = 50
      delete_on_termination = true
    }
}

build {
  sources = ["source.amazon-ebs.vpn"]
  provisioner "shell" {
    script = "installvpn.sh"
  }
}

build {
  sources = ["source.amazon-ebs.sonarqube"]
  provisioner "shell" {
    script = "installsonarqube.sh"
  }
}
