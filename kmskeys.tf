#KMS key for s3 encryption
resource "aws_kms_key" "aws-s3-kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  is_enabled              = true
  tags = {
    Name      = "prepaire-aws-s3"
    Terraform = "true"
  }
}

resource "aws_kms_alias" "aws-s3-key-alias" {
  name          = "alias/prepaire-aws-s3"
  target_key_id = aws_kms_key.aws-s3-kms-key.key_id
}

#KMS key for ECR encryption

resource "aws_kms_key" "aws-ecr-kms-key" {
  description             = "This key is used to encrypt ECR images"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  is_enabled              = true
  tags = {
    Name      = "prepaire-aws-ecr"
    Terraform = "true"
  }
}

resource "aws_kms_alias" "aws-ecr-key-alias" {
  name          = "alias/prepaire-aws-ecr"
  target_key_id = aws_kms_key.aws-ecr-kms-key.key_id
}


#KMS key for document DB encryption

resource "aws_kms_key" "aws-db-kms-key" {
  description             = "This key is used to encrypt DocumentDB"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  is_enabled              = true
  tags = {
    Name      = "prepaire-aws-db"
    Terraform = "true"
  }
}

resource "aws_kms_alias" "aws-db-key-alias" {
  name          = "alias/prepaire-aws-db"
  target_key_id = aws_kms_key.aws-db-kms-key.key_id
}

resource "aws_kms_key" "aws-cloudwatch-kms-key" {
  description             = "This key is used to encrypt cloudwatch logs"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  is_enabled              = true
  tags = {
    Name      = "prepaire-cloudwatch"
    Terraform = "true"
  }
}

resource "aws_kms_alias" "aws-cloudwatch-key-alias" {
  name          = "alias/prepaire-cloudwatch-logs"
  target_key_id = aws_kms_key.aws-cloudwatch-kms-key.key_id
}