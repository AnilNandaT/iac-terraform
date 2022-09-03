data "aws_ami" "vpn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["vpn"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["665246913124"]
}

data "aws_ami" "sonarqube" {
  most_recent = true

  filter {
    name   = "name"
    values = ["sonarqube"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["665246913124"]
}

# resource "aws_instance" "vpn" {
#   ami           = data.aws_ami.vpn.id
#   instance_type = "t3.medium"
#   security_groups = [aws_security_group.prepaire-ec2-vpn.id]
#   subnet_id = aws_subnet.prepaire-prvt-1a.id
#   source_dest_check = false
#   iam_instance_profile = aws_iam_instance_profile.ec2_default_profile.name
#   key_name = "prepaire-26May2022"
#   tags = {
#     Name = "pritunl-vpn-server"
#   }
# }


# resource "aws_instance" "sonarqube" {
#   ami           = data.aws_ami.sonarqube.id
#   instance_type = "t3.medium"
#   security_groups = [aws_security_group.prepaire-ec2-sonarqube.id]
#   subnet_id = aws_subnet.prepaire-prvt-1a.id
#   source_dest_check = false
#   iam_instance_profile = aws_iam_instance_profile.ec2_default_profile.name
#   key_name = "prepaire-26May2022"
#   tags = {
#     Name = "pritunl-sonarqube-server"
#   }
# }