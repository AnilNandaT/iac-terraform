#S3 access log bucket
resource "aws_s3_bucket" "s3-log-bucket" {
  # checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required for cost saving
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  bucket = "prepaire-s3-accesslogs-use1"
  acl    = "log-delivery-write"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.aws-s3-kms-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-s3-log-public-block" {
  bucket                  = aws_s3_bucket.s3-log-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "s3-log-bucket-config" {
  bucket = aws_s3_bucket.s3-log-bucket.bucket

  rule {
    id = "s3-log-lifecycle-policy"

    expiration {
      days = 90
    }

    status = "Enabled"

    transition {
      days          = 20
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 45
      storage_class = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 5
    }
  }
}

#create s3 bucket for flowlogs

resource "aws_s3_bucket" "prepaire-vpc-flowlogs-bucket" {
	# checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  bucket = "prepaire-${var.environment}-vpc-flowlogs"
    #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-vpc-flowlogs/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }
  tags = {
    Name      = "prepaire-${var.environment}-vpc-flowlogs"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_acl" "prepaire-vpc-flowlogs-bucket-acl" {
  bucket = aws_s3_bucket.prepaire-vpc-flowlogs-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "prepaire-flowlogs-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-vpc-flowlogs-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "flowlogs-log-bucket-config" {
  bucket = aws_s3_bucket.prepaire-vpc-flowlogs-bucket.bucket

  rule {
    id = "s3-log-lifecycle-policy"

    expiration {
      days = 90
    }

    status = "Enabled"

    transition {
      days          = 20
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 45
      storage_class = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 5
    }
  }
}


#ELB logs s3 bucket

resource "aws_s3_bucket" "prepaire-elb-logs-bucket" {
  bucket = "prepaire-${var.environment}-elb-logs"
	# checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
   {"Effect": "Allow",
   "Principal": {"AWS": "arn:aws:iam::127311923021:root"},
   "Action": "s3:PutObject",
   "Resource": "arn:aws:s3:::prepaire-${var.environment}-elb-logs/*"}]}
EOF
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-elb-logs"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-elb-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-elb-logs-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "elb-log-bucket-config" {
  bucket = aws_s3_bucket.prepaire-elb-logs-bucket.bucket

  rule {
    id = "s3-log-lifecycle-policy"

    expiration {
      days = 90
    }

    status = "Enabled"

    transition {
      days          = 20
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 45
      storage_class = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 5
    }
  }
}


# S3 bucket for lambda artifact storage

resource "aws_s3_bucket" "prepaire-lambda-artifact-bucket" {
  bucket = "prepaire-${var.environment}-lambda-artifact-us"
  # checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-lambda-artifact-us/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-lambda-artifact-us"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-lambda-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-lambda-artifact-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lambda-artifact-bucket-config" {
  bucket = aws_s3_bucket.prepaire-lambda-artifact-bucket.bucket

  rule {
    id = "s3-log-lifecycle-policy"

    expiration {
      days = 90
    }

    status = "Enabled"

    transition {
      days          = 20
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 45
      storage_class = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 5
    }
  }
}


# S3 bucket for pdf processing

resource "aws_s3_bucket" "prepaire-pdf-processing-bucket" {
  bucket = "prepaire-${var.environment}-pdf-processing"
  # checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-pdf-processing/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-pdf-processing"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-pdf-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-pdf-processing-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}


# S3 bucket for drug search

resource "aws_s3_bucket" "prepaire-drug-search-data-bucket" {
	# checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  bucket = "prepaire-${var.environment}-drug-search-data"
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-drug-search-data/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-drug-search-data"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-drug-search-data-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-drug-search-data-bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}


# S3 bucket for pdb files

resource "aws_s3_bucket" "prepaire-pdb-files" {
	# checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  bucket = "prepaire-${var.environment}-pdb-files"
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-pdb-files/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-pdb-files"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-pdb-files-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-pdb-files.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}



# S3 bucket for drug-search pdf files

resource "aws_s3_bucket" "prepaire-db-repo-files" {
	# checkov:skip=CKV_AWS_144: Cross origin replication not required
	# checkov:skip=CKV_AWS_21: Version not required
  bucket = "prepaire-${var.environment}-db-repo-files"
  #checkov:skip=CKV_AWS_18:Not enabling access logs for accesslog bucket
  #checkov:skip=CKV_AWS_145:KMS key encryption cannot be enabled for alb access logs bucket
  acl    = "private"
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "prepaire-${var.environment}-db-repo-files/"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  tags = {
    Name      = "prepaire-${var.environment}-db-repo-files"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "prepaire-db-repo-files-s3-public-block" {
  bucket                  = aws_s3_bucket.prepaire-db-repo-files.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}