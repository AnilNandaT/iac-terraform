#ECR life cycle policy

locals {
  repo_lifecycle_policy = jsonencode({
    rules = [
      {
        action       = { type = "expire" }
        description  = "string"
        rulePriority = 1
        selection = {
          countNumber = 5
          countType   = "imageCountMoreThan"
          tagStatus   = "any"
        }
      }
    ]
  })
}

#ECR repo for drug interaction
resource "aws_ecr_repository" "prepaire-drug-interaction" {
  name = "prepaire-${var.environment}-drug-interaction"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-drug-interaction-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-drug-interaction.name
  policy = local.repo_lifecycle_policy
}


#ECR repo for text2xdl
resource "aws_ecr_repository" "prepaire-text2xdl" {
  name = "prepaire-${var.environment}-text2xdl"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-text2xdl-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-text2xdl.name
  policy = local.repo_lifecycle_policy
}

#ECR repo for drug protein
resource "aws_ecr_repository" "prepaire-drug-protein" {
  name = "prepaire-${var.environment}-drug-protein"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-drug-protein-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-drug-protein.name
  policy = local.repo_lifecycle_policy
}

#ECR repo for solubility
resource "aws_ecr_repository" "prepaire-solubility" {
  name = "prepaire-${var.environment}-solubility"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-solubility-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-solubility.name
  policy = local.repo_lifecycle_policy
}


#ECR repo for toxicity
resource "aws_ecr_repository" "prepaire-toxicity" {
  name = "prepaire-${var.environment}-toxicity"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-toxicity-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-toxicity.name
  policy = local.repo_lifecycle_policy
}

#ECR repo for drug search
resource "aws_ecr_repository" "prepaire-drug-search" {
  name = "prepaire-${var.environment}-drug-search"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-drug-search-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-drug-search.name
  policy = local.repo_lifecycle_policy
}

#ECR repo for pdf-xdl
resource "aws_ecr_repository" "prepaire-pdf-xdl" {
  name = "prepaire-${var.environment}-pdf-xdl"
  #checkov:skip=CKV_AWS_51:Image tags has to be mutable
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.aws-ecr-kms-key.arn
  }
}

resource "aws_ecr_lifecycle_policy" "prepaire-pdf-xdl-ecrpolicy" {
  repository = aws_ecr_repository.prepaire-pdf-xdl.name
  policy = local.repo_lifecycle_policy
}