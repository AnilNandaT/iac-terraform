#Datasource
data "terraform_remote_state" "main" {
  backend = "remote"

  config = {
    organization = "prepaire"
    workspaces = {
      name = "${var.environment}"
    }
  }
}

#Lambda function for drug-interaction
resource "aws_lambda_function" "drug-interaction-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-drug-interaction"
  role          = data.terraform_remote_state.main.outputs.drug-interaction-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/drug-interaction-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:80"
    }
  }
}


#Lambda function for drug-protein
resource "aws_lambda_function" "drug-protein-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-drug-protein"
  role          = data.terraform_remote_state.main.outputs.drug-protein-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/drug-protein-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:8090"
    }
  }
}


#Lambda function for text2xdl
resource "aws_lambda_function" "text2xdl-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-text2xdl"
  role          = data.terraform_remote_state.main.outputs.text2xdl-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/text2xdl-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = 30
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:8080"
    }
  }
}


#Lambda function for solubility
resource "aws_lambda_function" "solubility-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-solubility"
  role          = data.terraform_remote_state.main.outputs.solubility-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/solubility-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:9090"
    }
  }
}


#Lambda function for toxicity
resource "aws_lambda_function" "toxicity-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-toxicity"
  role          = data.terraform_remote_state.main.outputs.toxicity-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/toxicity-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:9200"
    }
  }
}

#Lambda function for drug-search
resource "aws_lambda_function" "drug-search-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-drug-search"
  role          = data.terraform_remote_state.main.outputs.drug-search-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/drug-search-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = "30"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:9500"
    }
  }
}

#Lambda function for pdf-xdl
resource "aws_lambda_function" "pdf-xdl-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-pdf-xdl"
  role          = data.terraform_remote_state.main.outputs.pdf-xdl-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/pdf-xdl-latest.zip"
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = "30"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
  environment {
    variables = {
      MODEL_URL = "https://models-${var.environment}.prepaire.com:9100"
    }
  }
}

#Lambda function for drugshot-search
resource "aws_lambda_function" "drugshot-search-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-drugshot-search"
  role          = data.terraform_remote_state.main.outputs.drugshot-search-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/drugshot-search-latest.zip"
  reserved_concurrent_executions = -1
  runtime = "python3.9"
  timeout = "30"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
}

#Lambda function for drugshot-associate
resource "aws_lambda_function" "drugshot-associate-lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
	# checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = "prepaire-${var.environment}-drugshot-associate"
  role          = data.terraform_remote_state.main.outputs.drugshot-associate-lambda-role-arn
  handler       = "lambda_function.lambda_handler"
  s3_bucket = data.terraform_remote_state.main.outputs.prepaire-lambda-artifact-bucket-id
  s3_key = "latest/drugshot-associate-latest.zip"
  reserved_concurrent_executions = -1
  runtime = "python3.9"
  timeout = "30"
  vpc_config {
    subnet_ids         = [data.terraform_remote_state.main.outputs.prepaire-prvt-1a-id,data.terraform_remote_state.main.outputs.prepaire-prvt-1b-id]
    security_group_ids = [data.terraform_remote_state.main.outputs.prepaire-lambda-sg-id]
  }
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSDataWrangler-Python39:5"]
}
