#Lambda function for backend
resource "aws_lambda_function" "drugbank-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-drugbank"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-drugbank-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend
resource "aws_lambda_function" "drugbankQuery-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-drugbankQuery"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-drugbankQuery-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  memory_size = 512
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend
resource "aws_lambda_function" "targetsQuery-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-targetsQuery"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-targetsQuery-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for backend
resource "aws_lambda_function" "categoriesQuery-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-categoriesQuery"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-categoriesQuery-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend
resource "aws_lambda_function" "drugsByCategory-lambda" {
	# checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-drugsByCategory"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-drugsByCategory-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend
resource "aws_lambda_function" "getAfPdbUrl-lambda" {
	# checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-getAfPdbUrl"
  role          = data.terraform_remote_state.main.outputs.backend-get-af-pdb-url-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-getAfPdbUrl-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      BUCKET_NAME = "prepaire-${var.environment}-pdb-files"
    }
  }
}

#Lambda function for backend
resource "aws_lambda_function" "calculateMaintenanceDosage-lambda" {
	# checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-calculateMaintenanceDosage"
  role          = data.terraform_remote_state.main.outputs.backend-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-calculateMaintenanceDosage-latest.zip"
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  reserved_concurrent_executions = -1
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend pdf upload
resource "aws_lambda_function" "backend-pdf-xdl-lambda" {
	# checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-uploadPdf"
  role          = data.terraform_remote_state.main.outputs.backend-pdf-xdl-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-uploadPdf-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      BUCKET_NAME = "prepaire-${var.environment}-pdf-processing"
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend molecule search
resource "aws_lambda_function" "backend-molecule-search-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-drugbank-moleculesQuery"
  role          = data.terraform_remote_state.main.outputs.backend-molecule-search-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-drugbank-moleculesQuery-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for backend lotus
resource "aws_lambda_function" "backend-lotus-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-lotus-query"
  role          = data.terraform_remote_state.main.outputs.backend-lotus-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-lotus-query-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for backend natural products
resource "aws_lambda_function" "backend-natural-products-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-natural_products-query"
  role          = data.terraform_remote_state.main.outputs.backend-natural-products-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-natural_products-query-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for xdl add
resource "aws_lambda_function" "backend-xdl-add-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-add"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-add-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-add-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for xdl change status
resource "aws_lambda_function" "backend-xdl-change-status-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-changeStatus"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-change-status-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-changeStatus-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for xdl get details
resource "aws_lambda_function" "backend-xdl-get-details-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-getDetails"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-get-details-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-getDetails-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for xdl get file
resource "aws_lambda_function" "backend-xdl-get-file-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-getFileUrl"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-get-file-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-getFileUrl-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      BUCKET_NAME = "prepaire-${var.environment}-pdf-processing"
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for xdl get list
resource "aws_lambda_function" "backend-xdl-get-list-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-getList"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-get-list-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-getList-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for xdl search
resource "aws_lambda_function" "backend-xdl-search-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-xdl-search"
  role          = data.terraform_remote_state.main.outputs.backend-xdl-search-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-xdl-search-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for xdl search
resource "aws_lambda_function" "backend-3d-plot-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-3dplot"
  role          = data.terraform_remote_state.main.outputs.backend-plot3d-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-3dplot-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}


#Lambda function for auth forgetpasswordfirststep
resource "aws_lambda_function" "backend-auth-forgetpasswordfirststep-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-forgetPasswordFirstStep"
  role          = data.terraform_remote_state.main.outputs.backend-auth-forgetpasswordfirststep-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-forgetPasswordFirstStep-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      EMAIL_SENDER = "Prepaire <mail@prepaire.com>"
      MAIL_SQS_URL = "https://sqs.us-east-1.amazonaws.com/665246913124/prepaire-${var.environment}-user-email"
    }
  }
}

#Lambda function for auth forgetpasswordsecondstep
resource "aws_lambda_function" "backend-auth-forgetpasswordsecondstep-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-forgetPasswordSecondStep"
  role          = data.terraform_remote_state.main.outputs.backend-auth-forgetpasswordsecondstep-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-forgetPasswordSecondStep-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PRIVATE = var.access_token_private
      REFRESH_TOKEN_PRIVATE = var.refresh_token_private
    }
  }
}

#Lambda function for auth login
resource "aws_lambda_function" "backend-auth-login-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-login"
  role          = data.terraform_remote_state.main.outputs.backend-auth-login-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-login-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  memory_size = 512
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      EMAIL_SENDER = "Prepaire <mail@prepaire.com>"
      ACCESS_TOKEN_PRIVATE = var.access_token_private
      REFRESH_TOKEN_PRIVATE = var.refresh_token_private
      RESET_PASS_TOKEN_PRIVATE = var.reset_pass_token_private
    }
  }
}


#Lambda function for auth refreshtoken
resource "aws_lambda_function" "backend-auth-refreshtoken-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-refreshToken"
  role          = data.terraform_remote_state.main.outputs.backend-auth-refreshtoken-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-refreshToken-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PRIVATE = var.access_token_private
      REFRESH_TOKEN_PUBLIC = var.refresh_token_public
    }
  }
}


#Lambda function for auth resendforgetpasswordcode
resource "aws_lambda_function" "backend-auth-resendforgetpasswordcode-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-resendForgetPasswordCode"
  role          = data.terraform_remote_state.main.outputs.backend-auth-resendforgetpasswordcode-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-resendForgetPasswordCode-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      EMAIL_SENDER = "Prepaire <mail@prepaire.com>"
      MAIL_SQS_URL = "https://sqs.us-east-1.amazonaws.com/665246913124/prepaire-${var.environment}-user-email"
    }
  }
}

#Lambda function for auth resendverificationcode
resource "aws_lambda_function" "backend-auth-resendverificationcode-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-resendVerificationCode"
  role          = data.terraform_remote_state.main.outputs.backend-auth-resendverificationcode-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-resendVerificationCode-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      EMAIL_SENDER = "Prepaire <mail@prepaire.com>"
      MAIL_SQS_URL = "https://sqs.us-east-1.amazonaws.com/665246913124/prepaire-${var.environment}-user-email"
    }
  }
}

#Lambda function for auth verifyaccount
resource "aws_lambda_function" "backend-auth-verifyaccount-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-verifyAccount"
  role          = data.terraform_remote_state.main.outputs.backend-auth-verifyaccount-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-verifyAccount-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PRIVATE = var.access_token_private
      REFRESH_TOKEN_PRIVATE = var.refresh_token_private
    }
  }
}

#Lambda function for auth sendEmail
resource "aws_lambda_function" "backend-auth-sendemail-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-sendEmail"
  role          = data.terraform_remote_state.main.outputs.backend-auth-sendemail-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-sendEmail-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MAIL_HOST = "smtp.office365.com"
      MAIL_PORT = "587"
      MAIL_USER = "no-reply@prepaire.com"
      MAIL_PASS = "khyttxsspgsdshts"
    }
  }
}

resource "aws_lambda_event_source_mapping" "sendEmail" {
  event_source_arn = data.terraform_remote_state.main.outputs.user-email-sqs-queue-arn
  function_name    = aws_lambda_function.backend-auth-sendemail-lambda.arn
}

#Lambda function for auth authorizer
resource "aws_lambda_function" "api-authoriser-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-authorizer"
  role          = data.terraform_remote_state.main.outputs.api-authoriser-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-authorizer-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      ACCESS_TOKEN_PUBLIC = var.access_token_public
      MONGODB_CONNSTRING = var.db_connection_string
    }
  }
}

#Lambda function for auth resetPasswordFirstTime
resource "aws_lambda_function" "backend-auth-reset-password-first-time-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-resetPasswordFirstTime"
  role          = data.terraform_remote_state.main.outputs.backend-auth-reset-password-first-time-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-resetPasswordFirstTime-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      RESET_PASS_TOKEN_PUBLIC = var.reset_pass_token_public
      MONGODB_CONNSTRING = var.db_connection_string
      USAGE_PLAN_ID = "aqdx40"
    }
  }
}

#Lambda function for auth loginWith3rdParty
resource "aws_lambda_function" "backend-auth-loginWith3rdParty-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-loginWith3rdParty"
  role          = data.terraform_remote_state.main.outputs.backend-auth-loginWith3rdParty-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-loginWith3rdParty-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PRIVATE = var.access_token_private
      REFRESH_TOKEN_PRIVATE = var.refresh_token_private
    }
  }
}

#Lambda function for auth register
resource "aws_lambda_function" "backend-auth-register-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-auth-register"
  role          = data.terraform_remote_state.main.outputs.backend-auth-register-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-auth-register-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      MAIL_SQS_URL = "https://sqs.us-east-1.amazonaws.com/665246913124/prepaire-${var.environment}-user-email"
    }
  }
}

#Lambda function for profile get 
resource "aws_lambda_function" "backend-profile-get-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-profile-get"
  role          = data.terraform_remote_state.main.outputs.backend-profile-get-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-profile-get-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

#Lambda function for profile update 
resource "aws_lambda_function" "backend-profile-update-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-profile-update"
  role          = data.terraform_remote_state.main.outputs.backend-profile-update-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-profile-update-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

#Lambda function for profile changepassword 
resource "aws_lambda_function" "backend-profile-changepassword-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-profile-changePassword"
  role          = data.terraform_remote_state.main.outputs.backend-profile-changepassword-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-profile-changePassword-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

#Lambda function for usersmanagement add 
resource "aws_lambda_function" "backend-usersmanagement-add-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-add"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-add-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-add-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
      EMAIL_SENDER = "Prepaire <mail@prepaire.com>"
      MAIL_SQS_URL = "https://sqs.us-east-1.amazonaws.com/665246913124/prepaire-${var.environment}-user-email"
    }
  }
}


#Lambda function for usersmanagement delete 
resource "aws_lambda_function" "backend-usersmanagement-delete-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-delete"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-delete-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-delete-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

#Lambda function for usersmanagement update 
resource "aws_lambda_function" "backend-usersmanagement-update-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-update"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-update-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-update-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

#Lambda function for usersmanagement details 
resource "aws_lambda_function" "backend-usersmanagement-details-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-details"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-details-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-details-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

resource "aws_lambda_function" "backend-usersmanagement-list-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-list"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-list-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-list-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

resource "aws_lambda_function" "backend-usersmanagement-deactivate-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-deactivate"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-deactivate-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-deactivate-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
    }
  }
}

resource "aws_lambda_function" "backend-usersmanagement-approve-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-approve"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-approve-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-approve-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
      USAGE_PLAN_ID = "aqdx40"
    }
  }
}

resource "aws_lambda_function" "backend-usersmanagement-changeApiKey-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-backend-usersManagement-changeApiKey"
  role          = data.terraform_remote_state.main.outputs.backend-usersmanagement-changeApiKey-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/backend-usersManagement-changeApiKey-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:665246913124:layer:backend-layer-${var.environment}:36"]
  environment {
    variables = {
      MONGODB_CONNSTRING = var.db_connection_string
      ACCESS_TOKEN_PUBLIC = var.access_token_public
      USAGE_PLAN_ID = "aqdx40"
    }
  }
}