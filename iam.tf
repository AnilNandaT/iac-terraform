#EC2 default IAM role
resource "aws_iam_role" "prepaire-ec2-default" {
  name                = "prepaire-ec2-default-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-ec2-default-role"
  }
}

resource "aws_iam_instance_profile" "ec2_default_profile" {
  name = "prepaire_ec2_default_profile"
  role = aws_iam_role.prepaire-ec2-default.name
}

#IAM role for the task
resource "aws_iam_role" "prepaire-drug-interaction-task-role" {
  name                = "prepaire-${var.environment}-drug-interaction-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-drug-interaction-task-role"
  }
}


#text2xdl task role

resource "aws_iam_role" "prepaire-text2xdl-task-role" {
  name                = "prepaire-${var.environment}-text2xdl-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-text2xdl-task-role"
  }
}

#drug protein task role

resource "aws_iam_role" "prepaire-drug-protein-task-role" {
  name                = "prepaire-${var.environment}-drug-protein-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-drug-protein-task-role"
  }
}

#drug solubility task role

resource "aws_iam_role" "prepaire-solubility-task-role" {
  name                = "prepaire-${var.environment}-solubility-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-solubility-task-role"
  }
}

# toxicity task role

resource "aws_iam_role" "prepaire-toxicity-task-role" {
  name                = "prepaire-${var.environment}-toxicity-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-toxicity-task-role"
  }
}

# search engine task role

resource "aws_iam_role" "prepaire-drug-search-task-role" {
  name                = "prepaire-${var.environment}-drug-search-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-drug-search-task-role"
  }
}


# search engine task role

resource "aws_iam_role" "prepaire-pdf-xdl-task-role" {
  name                = "prepaire-${var.environment}-pdf-xdl-task-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",aws_iam_policy.pdf-xdl-s3-policy.arn]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "prepaire-${var.environment}-pdf-xdl-task-role"
  }
}



#IAM role for ECS instance

data "aws_iam_policy_document" "prepeaire-ecs-ec2-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "prepaire-ecs-instance-role" {
  name               = "prepaire-${var.environment}-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.prepeaire-ecs-ec2-policy.json
}


resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.prepaire-ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "prepaire-ecs-instance-profile" {
  name = "prepaire-${var.environment}-ecs-instance-profile"
  role = aws_iam_role.prepaire-ecs-instance-role.name
}

resource "aws_iam_policy" "lambda-logging" {
  name        = "prepaire-lambda-logging-policy"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:us-east-1:665246913124:*",
      "Effect": "Allow"
    },
    {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeNetworkInterfaces"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}

resource "aws_iam_policy" "ses-access" {
  name        = "prepaire-ses-policy"
  path        = "/"
  description = "IAM policy for ses access"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "pdf-xdl-s3-policy" {
  name        = "prepaire-pdf-xdl-s3-policy"
  path        = "/"
  description = "IAM policy for pdf-xdl model lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing",
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing/*"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_policy" "backend-pdf-xdl-lambda-policy" {
  name        = "prepaire-backend-pdf-xdl-lambda-policy"
  path        = "/"
  description = "IAM policy for s3 access of backend pdf-xdl lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing",
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "backend-xdl-get-file-lambda-policy" {
  name        = "prepaire-backend-xdl-get-file-lambda-policy"
  path        = "/"
  description = "IAM policy for s3 access of backend xdl getfile lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing",
                "arn:aws:s3:::prepaire-${var.environment}-pdf-processing/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "backend-get-af-pdb-url-lambda-policy" {
  name        = "prepaire-backend-get-af-pdb-url-lambda-policy"
  path        = "/"
  description = "IAM policy for s3 access of backend get pdb file url lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::prepaire-${var.environment}-pdb-files",
                "arn:aws:s3:::prepaire-${var.environment}-pdb-files/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "backend-ssm-lambda-policy" {
  name        = "prepaire-backend-ssm-lambda-policy"
  path        = "/"
  description = "IAM policy for ssm parameter access of backend lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": ["arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}PrepaireDocumentDB","arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}AccessTokenPrivate","arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}AccessTokenPublic","arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}EmailSender","arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}RefreshTokenPrivate","arn:aws:ssm:us-east-1:665246913124:parameter/${var.environment}RefreshTokenPublic"]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:DescribeParameters",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "backend-sqs-read-lambda-policy" {
  name        = "prepaire-backend-sqs-read-lambda-policy"
  path        = "/"
  description = "IAM policy for reading from sqs for backend sendemail lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": ["sqs:ReceiveMessage","sqs:DeleteMessage","sqs:GetQueueAttributes"],
            "Resource": "arn:aws:sqs:us-east-1:665246913124:prepaire-${var.environment}-user-email"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "sqs:ListQueues",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "backend-sqs-write-lambda-policy" {
  name        = "prepaire-backend-sqs-write-lambda-policy"
  path        = "/"
  description = "IAM policy for writing to sqs for backend sendemail lambda function"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "sqs:DeleteMessage",
                "sqs:SendMessage"
            ],
            "Resource": "arn:aws:sqs:us-east-1:665246913124:prepaire-${var.environment}-user-email"
        }
    ]
}
EOF
}




resource "aws_iam_policy" "backend-api-key-lambda-policy" {
  name        = "prepaire-backend-api-key-lambda-policy"
  path        = "/"
  description = "IAM policy for add and delete api keys"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "apigateway:DELETE",
                "apigateway:POST",
                "apigateway:GET"
            ],
            "Resource": [
                "arn:aws:apigateway:*::/apikeys/*",
                "arn:aws:apigateway:*::/usageplans",
                "arn:aws:apigateway:*::/apikeys",
                "arn:aws:apigateway:*::/usageplans/*/keys/*",
                "arn:aws:apigateway:*::/usageplans/*/keys"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "apigateway:DELETE",
                "apigateway:GET"
            ],
            "Resource": "arn:aws:apigateway:*::/usageplans/*"
        }
    ]
}
EOF
}


# IAM role for lambda function
resource "aws_iam_role" "drug-interaction-lambda-role" {
  name = "prepaire-${var.environment}-drug-interaction-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "drug-protein-lambda-role" {
  name = "prepaire-${var.environment}-drug-protein-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "text2xdl-lambda-role" {
  name = "prepaire-${var.environment}-text2xdl-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "solubility-lambda-role" {
  name = "prepaire-${var.environment}-solubility-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "toxicity-lambda-role" {
  name = "prepaire-${var.environment}-toxicity-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "drug-search-lambda-role" {
  name = "prepaire-${var.environment}-drug-search-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function
resource "aws_iam_role" "pdf-xdl-lambda-role" {
  name = "prepaire-${var.environment}-pdf-xdl-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "drugshot-search-lambda-role" {
  name = "prepaire-${var.environment}-drugshot-search-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function
resource "aws_iam_role" "drugshot-associate-lambda-role" {
  name = "prepaire-${var.environment}-drugshot-associate-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function
resource "aws_iam_role" "backend-lambda-role" {
  name = "prepaire-${var.environment}-backend-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend auth resetPasswordFirstTime
resource "aws_iam_role" "backend-get-af-pdb-url-lambda-role" {
  name = "prepaire-${var.environment}-backend-get-af-pdb-url-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-get-af-pdb-url-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend pdfxdl
resource "aws_iam_role" "backend-pdf-xdl-lambda-role" {
  name = "prepaire-${var.environment}-backend-pdf-xdl-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-pdf-xdl-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend molecule search
resource "aws_iam_role" "backend-molecule-search-lambda-role" {
  name = "prepaire-${var.environment}-backend-molecule-search-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend lotus
resource "aws_iam_role" "backend-lotus-lambda-role" {
  name = "prepaire-${var.environment}-backend-lotus-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend natural products
resource "aws_iam_role" "backend-natural-products-lambda-role" {
  name = "prepaire-${var.environment}-backend-natural-products-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl add
resource "aws_iam_role" "backend-xdl-add-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-add-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl change status
resource "aws_iam_role" "backend-xdl-change-status-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-change-status-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl get details
resource "aws_iam_role" "backend-xdl-get-details-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-get-details-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl get file
resource "aws_iam_role" "backend-xdl-get-file-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-get-file-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-xdl-get-file-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl get list
resource "aws_iam_role" "backend-xdl-get-list-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-get-list-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend xdl search
resource "aws_iam_role" "backend-xdl-search-lambda-role" {
  name = "prepaire-${var.environment}-backend-xdl-search-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend xdl search
resource "aws_iam_role" "backend-plot3d-lambda-role" {
  name = "prepaire-${var.environment}-backend-plot3d-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend auth forgetpasswordfirststep
resource "aws_iam_role" "backend-auth-forgetpasswordfirststep-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-forgetpasswordfirststep-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth forgetpasswordsecondstep
resource "aws_iam_role" "backend-auth-forgetpasswordsecondstep-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-forgetpasswordsecondstep-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth login
resource "aws_iam_role" "backend-auth-login-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-login-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend auth refreshtoken
resource "aws_iam_role" "backend-auth-refreshtoken-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-refreshtoken-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth resendforgetpasswordcode
resource "aws_iam_role" "backend-auth-resendforgetpasswordcode-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-resendforgetpasswordcode-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth resendverificationcode
resource "aws_iam_role" "backend-auth-resendverificationcode-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-resendverificationcode-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend auth verifyaccount
resource "aws_iam_role" "backend-auth-verifyaccount-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-verifyaccount-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth sendemail
resource "aws_iam_role" "backend-auth-sendemail-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-sendemail-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.ses-access.arn,aws_iam_policy.backend-sqs-read-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth resetPasswordFirstTime
resource "aws_iam_role" "backend-auth-reset-password-first-time-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-reset-password-first-time-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn,aws_iam_policy.backend-api-key-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend auth register
resource "aws_iam_role" "backend-auth-register-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-register-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth loginWith3rdParty
resource "aws_iam_role" "backend-auth-loginWith3rdParty-lambda-role" {
  name = "prepaire-${var.environment}-backend-auth-loginWith3rdParty-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}



# IAM role for lambda function for backend profile get
resource "aws_iam_role" "backend-profile-get-lambda-role" {
  name = "prepaire-${var.environment}-backend-profile-get-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend profile update
resource "aws_iam_role" "backend-profile-update-lambda-role" {
  name = "prepaire-${var.environment}-backend-profile-update-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend profile changepassword
resource "aws_iam_role" "backend-profile-changepassword-lambda-role" {
  name = "prepaire-${var.environment}-backend-profile-changepassword-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


# IAM role for lambda function for backend usersmanagement add
resource "aws_iam_role" "backend-usersmanagement-add-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-add-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement delete
resource "aws_iam_role" "backend-usersmanagement-delete-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-delete-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn,aws_iam_policy.backend-api-key-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement update
resource "aws_iam_role" "backend-usersmanagement-update-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-update-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement details
resource "aws_iam_role" "backend-usersmanagement-details-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-details-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement list
resource "aws_iam_role" "backend-usersmanagement-list-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-list-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-ssm-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement deactivate
resource "aws_iam_role" "backend-usersmanagement-deactivate-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-deactivate-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-api-key-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement approve
resource "aws_iam_role" "backend-usersmanagement-approve-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-approve-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-api-key-lambda-policy.arn,aws_iam_policy.backend-sqs-write-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend usersmanagement changeApiKey
resource "aws_iam_role" "backend-usersmanagement-changeapikey-lambda-role" {
  name = "prepaire-${var.environment}-backend-usersmanagement-changeapikey-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn,aws_iam_policy.backend-api-key-lambda-policy.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# IAM role for lambda function for backend auth login
resource "aws_iam_role" "api-authoriser-lambda-role" {
  name = "prepaire-${var.environment}-api-authoriser-lambda-role"
  managed_policy_arns = [aws_iam_policy.lambda-logging.arn]
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}