#SG for ECS instance

resource "aws_security_group" "prepaire-ecs-sg" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-${var.environment}-ecs-sg"
  description = "SG for EC2 instances in ECS cluster"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound Traffic from ELB"
    from_port   = 30000
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allows all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prepaire-${var.environment}-ecs-sg"
  }
}

#Create ELB security group

resource "aws_security_group" "prepaire-ecs-elb-sg" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-${var.environment}-ecs-elb-sg"
  description = "SG for ELB exposing ECS services"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "drug-interaction listener port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "text2xdl listener port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "solubility listener port"
    from_port   = 8090
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "drug-protein listener port"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "toxicity listener port"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "drug-search listener port"
    from_port   = 9500
    to_port     = 9500
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }
  ingress {
    description = "pdf-xdl listener port"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allows all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prepaire-${var.environment}-ecs-elb-sg"
  }
}

#Create DB SG
resource "aws_security_group" "prepaire-db-sg" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-${var.environment}-db-sg"
  description = "Allow inbound traffic to database"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound traffic from vpc"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allow all Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "prepaire-${var.environment}-db-sg"
    Terraform = "true"
  }
}


#Create Neptune DB SG
resource "aws_security_group" "prepaire-neptune-db-sg" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-${var.environment}-neptune-db-sg"
  description = "Allow inbound traffic to neptune database"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound traffic from vpc"
    from_port   = 8182
    to_port     = 8182
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allow all Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "prepaire-${var.environment}-neptune-db-sg"
    Terraform = "true"
  }
}

#SG for lambda functions

resource "aws_security_group" "prepaire-lambda-sg" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-${var.environment}-lambda-sg"
  description = "Allow inbound traffic to prepaire lambda functions"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound traffic from vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allow all Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "prepaire-${var.environment}-lambda-sg"
    Terraform = "true"
  }
}


#SG for vpn server

resource "aws_security_group" "prepaire-ec2-vpn" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-pritunl-vpn-sg"
  description = "Allow inbound traffic for vpn server"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound traffic from vpc"
    from_port   = 1557
    to_port     = 1557
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allow all Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "prepaire-${var.environment}-vpn-sg"
    Terraform = "true"
  }
}


#SG for vpn server

resource "aws_security_group" "prepaire-ec2-sonarqube" {
	# checkov:skip=CKV2_AWS_5: ADD REASON
  name        = "prepaire-pritunl-sonarqube-sg"
  description = "Allow inbound traffic for sonarqube server"
  vpc_id      = aws_vpc.prepaire-vpc.id

  ingress {
    description = "Inbound traffic from vpc"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.prepaire-vpc.cidr_block]
  }

  egress {
    description = "Allow all Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "prepaire-${var.environment}-sonarqube-sg"
    Terraform = "true"
  }
}