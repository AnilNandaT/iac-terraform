#Create VPC
resource "aws_vpc" "prepaire-vpc" {
  #provider         = aws.us
  cidr_block       = "10.0.2.0/23"
  instance_tenancy = "default"
  tags = {
    Name      = "prepaire-${var.environment}"
    Terraform = "true"
  }
}

#Create Internet gw
resource "aws_internet_gateway" "prepaire-igw" {
  vpc_id = aws_vpc.prepaire-vpc.id

  tags = {
    Name      = "prepaire-${var.environment}-igw"
    Terraform = "true"
  }
}

#EIP for NAT gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
  tags = {
    Name      = "prepaire-${var.environment}-nat-gw"
    Terraform = "true"
  }
}

#Create NAT gateway
resource "aws_nat_gateway" "prepaire-nat-gw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.prepaire-pub-1a.id

  tags = {
    Name      = "prepaire-${var.environment}-nat-gw"
    Terraform = "true"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.prepaire-igw]
}

#Create Public 1 subnet
resource "aws_subnet" "prepaire-pub-1a" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.2.0/26"
  availability_zone = "us-east-1a"
  tags = {
    Name      = "prepaire-${var.environment}-pub-1a"
    Terraform = "true"
  }
}

#Create Public 2 subnet
resource "aws_subnet" "prepaire-pub-1b" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.2.64/26"
  availability_zone = "us-east-1b"

  tags = {
    Name      = "perpaire-${var.environment}-pub-1b"
    Terraform = "true"
  }
}

#Create Private 1 subnet
resource "aws_subnet" "prepaire-prvt-1a" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.3.0/25"
  availability_zone = "us-east-1a"

  tags = {
    Name      = "perpaire-${var.environment}-prvt-1a"
    Terraform = "true"
  }
}

#Create Private 2 subnet
resource "aws_subnet" "prepaire-prvt-1b" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.3.128/25"
  availability_zone = "us-east-1b"

  tags = {
    Name      = "perpaire-${var.environment}-prvt-1b"
    Terraform = "true"
  }
}

#Create DB 1 subnet
resource "aws_subnet" "prepaire-db-1a" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.2.128/26"
  availability_zone = "us-east-1a"

  tags = {
    Name      = "perpaire-${var.environment}-db-1a"
    Terraform = "true"
  }
}

#Create DB 2 subnet
resource "aws_subnet" "prepaire-db-1b" {
  vpc_id            = aws_vpc.prepaire-vpc.id
  cidr_block        = "10.0.2.192/26"
  availability_zone = "us-east-1b"

  tags = {
    Name      = "perpaire-${var.environment}-db-1b"
    Terraform = "true"
  }
}

# Build public route table
resource "aws_route_table" "prepaire-pub-rt" {
  vpc_id = aws_vpc.prepaire-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prepaire-igw.id
  }

  route {
    cidr_block        = "10.0.0.0/23"
    vpc_peering_connection_id = "pcx-088398315fc73f945"
  }


  tags = {
    Name      = "prepaire-${var.environment}-pub-rt"
    Terraform = "true"
  }
}

# Build private route table
resource "aws_route_table" "prepaire-prvt-rt" {
  vpc_id = aws_vpc.prepaire-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prepaire-nat-gw.id
  }

  route {
    cidr_block        = "10.0.0.0/23"
    vpc_peering_connection_id = "pcx-088398315fc73f945"
  }

  tags = {
    Name      = "prepaire-${var.environment}-prvt-rt"
    Terraform = "true"
  }
}

# Build database route table
resource "aws_route_table" "prepaire-db-rt" {
  vpc_id = aws_vpc.prepaire-vpc.id

  tags = {
    Name      = "prepaire-${var.environment}-db-rt"
    Terraform = "true"
  }
}

#Associate RT with subnet
resource "aws_route_table_association" "pub-1-rt-association" {
  subnet_id      = aws_subnet.prepaire-pub-1a.id
  route_table_id = aws_route_table.prepaire-pub-rt.id
}

#Associate RT with subnet
resource "aws_route_table_association" "pub-2-rt-association" {
  subnet_id      = aws_subnet.prepaire-pub-1b.id
  route_table_id = aws_route_table.prepaire-pub-rt.id
}

#Associate RT with subnet
resource "aws_route_table_association" "prvt-1-rt-association" {
  subnet_id      = aws_subnet.prepaire-prvt-1a.id
  route_table_id = aws_route_table.prepaire-prvt-rt.id
}

#Associate RT with subnet
resource "aws_route_table_association" "prvt-2-rt-association" {
  subnet_id      = aws_subnet.prepaire-prvt-1b.id
  route_table_id = aws_route_table.prepaire-prvt-rt.id
}

#Associate RT with subnet
resource "aws_route_table_association" "db-1-rt-association" {
  subnet_id      = aws_subnet.prepaire-db-1a.id
  route_table_id = aws_route_table.prepaire-db-rt.id
}

#Associate RT with subnet
resource "aws_route_table_association" "db-2-rt-association" {
  subnet_id      = aws_subnet.prepaire-db-1b.id
  route_table_id = aws_route_table.prepaire-db-rt.id
}

#Delete all entries from default SG
resource "aws_default_security_group" "prepaire-default-sg" {
  vpc_id = aws_vpc.prepaire-vpc.id
}

#Remove entries from default nacl

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.prepaire-vpc.default_network_acl_id
}

#create NACLS
resource "aws_network_acl" "prepaire-pub-nacl" {
  vpc_id     = aws_vpc.prepaire-vpc.id
  subnet_ids = [aws_subnet.prepaire-pub-1a.id, aws_subnet.prepaire-pub-1b.id]
  egress {
    protocol   = -1
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 20
    to_port    = 21
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name      = "prepaire-${var.environment}-pub-nacl"
    Terraform = "true"
  }
}

resource "aws_network_acl" "prepaire-prvt-nacl" {
  vpc_id     = aws_vpc.prepaire-vpc.id
  subnet_ids = [aws_subnet.prepaire-prvt-1a.id, aws_subnet.prepaire-prvt-1b.id]
  egress {
    protocol   = -1
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 20
    to_port    = 21
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name      = "prepaire-${var.environment}-prvt-nacl"
    Terraform = "true"
  }
}

resource "aws_network_acl" "prepaire-db-nacl" {
  vpc_id     = aws_vpc.prepaire-vpc.id
  subnet_ids = [aws_subnet.prepaire-db-1a.id, aws_subnet.prepaire-db-1b.id]
  egress {
    protocol   = -1
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 20
    to_port    = 21
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    to_port    = 3389
  }


  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name      = "prepaire-${var.environment}-db-nacl"
    Terraform = "true"
  }
}

# #Associate NACLs with subnet
# resource "aws_network_acl_association" "prepaire-pub-1a-nacl" {
#   network_acl_id = aws_network_acl.prepaire-pub-nacl.id
#   subnet_id      = aws_subnet.prepaire-pub-1a.id
# }

# resource "aws_network_acl_association" "prepaire-pub-1b-nacl" {
#   network_acl_id = aws_network_acl.prepaire-pub-nacl.id
#   subnet_id      = aws_subnet.prepaire-pub-1b.id
# }

# resource "aws_network_acl_association" "prepaire-prvt-1a-nacl" {
#   network_acl_id = aws_network_acl.prepaire-prvt-nacl.id
#   subnet_id      = aws_subnet.prepaire-prvt-1a.id
# }

# resource "aws_network_acl_association" "prepaire-prvt-1b-nacl" {
#   network_acl_id = aws_network_acl.prepaire-prvt-nacl.id
#   subnet_id      = aws_subnet.prepaire-prvt-1b.id
# }

# resource "aws_network_acl_association" "prepaire-db-1a-nacl" {
#   network_acl_id = aws_network_acl.prepaire-db-nacl.id
#   subnet_id      = aws_subnet.prepaire-db-1a.id
# }

# resource "aws_network_acl_association" "prepaire-db-1b-nacl" {
#   network_acl_id = aws_network_acl.prepaire-db-nacl.id
#   subnet_id      = aws_subnet.prepaire-db-1b.id
# }


#s3 endpoint for vpc
resource "aws_vpc_endpoint" "prepaire-s3-endpoint" {
  vpc_id       = aws_vpc.prepaire-vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    "Name"    = "prepaire-${var.environment}-s3-endpoint"
    Terraform = "true"
  }
}

resource "aws_vpc_endpoint_route_table_association" "prepaire-pub-endpoint" {
  route_table_id  = aws_route_table.prepaire-pub-rt.id
  vpc_endpoint_id = aws_vpc_endpoint.prepaire-s3-endpoint.id
}

resource "aws_vpc_endpoint_route_table_association" "prepaire-prvt-endpoint" {
  route_table_id  = aws_route_table.prepaire-prvt-rt.id
  vpc_endpoint_id = aws_vpc_endpoint.prepaire-s3-endpoint.id
}

#Enable flowlogs
resource "aws_flow_log" "prepaire-vpc-flowlogs" {
  log_destination      = aws_s3_bucket.prepaire-vpc-flowlogs-bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.prepaire-vpc.id
}
