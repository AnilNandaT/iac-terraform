

resource "aws_lambda_function" "backend_lambda" {
  # checkov:skip=CKV_AWS_116: Disable DLQ for lambda
  # checkov:skip=CKV_AWS_50: Enable X-Ray when needed
  function_name = var.function_name
  role          = var.iam_role
  handler       = "lambda_function.lambda_handler"
  s3_bucket = var.lambda_s3_bucket
  s3_key = var.lambda_s3_artifact
  reserved_concurrent_executions = -1
  kms_key_arn = "arn:aws:kms:us-east-1:665246913124:key/35b402c1-47c0-4b7f-a874-a865ce7793bf"
  runtime = "python3.9"
  timeout = var.timeout
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group
  }
  layers = var.lambda_layer
  environment {
    variables = {
      PARAM_STORE_MONGODB = "devPrepaireDocumentDB"
      PS_ACCESS_TOKEN_PUBLIC = "devAccessTokenPublic"
    }
  }
}