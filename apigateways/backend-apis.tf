#Backend APIs

#drugshot resource
resource "aws_api_gateway_resource" "drugbank-resource" {
  path_part   = "drugbank"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drugbank-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drugbank-resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "drugbank-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drugbank-resource.id
  http_method             = aws_api_gateway_method.drugbank-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.drugbank-lambda-invoke_arn
}

resource "aws_lambda_permission" "drugbank-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drugbank-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drugbank-method.http_method}${aws_api_gateway_resource.drugbank-resource.path}"
}

module "drugbank-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.drugbank-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}


#category/query resource
resource "aws_api_gateway_resource" "category-resource" {
  path_part   = "category"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "category-query-resource" {
  path_part   = "query"
  parent_id   = aws_api_gateway_resource.category-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "category-query-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.category-query-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "category-query-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.category-query-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "category-query-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.category-query-proxy-resource.id
  http_method             = aws_api_gateway_method.category-query-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.categoriesQuery-lambda-invoke_arn
}

resource "aws_lambda_permission" "category-query-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.categoriesQuery-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.category-query-proxy-method.http_method}${aws_api_gateway_resource.category-query-proxy-resource.path}"
}

module "category-query-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.category-query-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}


#drugs/category resource
resource "aws_api_gateway_resource" "drugs-resource" {
  path_part   = "drugs"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "drugs-category-resource" {
  path_part   = "category"
  parent_id   = aws_api_gateway_resource.drugs-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "drugs-category-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.drugs-category-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drugs-category-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drugs-category-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "drugs-category-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drugs-category-proxy-resource.id
  http_method             = aws_api_gateway_method.drugs-category-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.drugsByCategory-lambda-invoke_arn
}

resource "aws_lambda_permission" "drugs-category-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drugsByCategory-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drugs-category-proxy-method.http_method}${aws_api_gateway_resource.drugs-category-proxy-resource.path}"
}

module "drugs-category-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.drugs-category-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#target/query resource
resource "aws_api_gateway_resource" "target-resource" {
  path_part   = "target"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "target-query-resource" {
  path_part   = "query"
  parent_id   = aws_api_gateway_resource.target-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "target-query-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.target-query-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "target-query-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.target-query-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "target-query-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.target-query-proxy-resource.id
  http_method             = aws_api_gateway_method.target-query-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.targetsQuery-lambda-invoke_arn
}

resource "aws_lambda_permission" "target-query-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.targetsQuery-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.target-query-proxy-method.http_method}${aws_api_gateway_resource.target-query-proxy-resource.path}"
}

module "target-query-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.target-query-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#molecule resource
resource "aws_api_gateway_resource" "molecule-resource" {
  path_part   = "molecule"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "molecule-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.molecule-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "molecule-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.molecule-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "molecule-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.molecule-proxy-resource.id
  http_method             = aws_api_gateway_method.molecule-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-molecule-search-lambda-invoke_arn
}

resource "aws_lambda_permission" "molecule-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-molecule-search-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.molecule-proxy-method.http_method}${aws_api_gateway_resource.molecule-proxy-resource.path}"
}

module "molecule-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.molecule-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#getAfPdbUrl resource
resource "aws_api_gateway_resource" "getAfPdbUrl-resource" {
  path_part   = "getAfPdbUrl"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "getAfPdbUrl-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.getAfPdbUrl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "getAfPdbUrl-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.getAfPdbUrl-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "getAfPdbUrl-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.getAfPdbUrl-proxy-resource.id
  http_method             = aws_api_gateway_method.getAfPdbUrl-proxy-method.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.getAfPdbUrl-lambda-invoke_arn
}

resource "aws_lambda_permission" "getAfPdbUrl-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.getAfPdbUrl-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.getAfPdbUrl-proxy-method.http_method}${aws_api_gateway_resource.getAfPdbUrl-proxy-resource.path}"
}

module "getAfPdbUrl-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.getAfPdbUrl-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#calculateMaintenanceDosage resource
resource "aws_api_gateway_resource" "calculateMaintenanceDosage-resource" {
  path_part   = "calculateMaintenanceDosage"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "calculateMaintenanceDosage-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.calculateMaintenanceDosage-resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "calculateMaintenanceDosage-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.calculateMaintenanceDosage-resource.id
  http_method             = aws_api_gateway_method.calculateMaintenanceDosage-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.calculateMaintenanceDosage-lambda-invoke_arn
}

resource "aws_lambda_permission" "calculateMaintenanceDosage-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.calculateMaintenanceDosage-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.calculateMaintenanceDosage-method.http_method}${aws_api_gateway_resource.calculateMaintenanceDosage-resource.path}"
}

module "calculateMaintenanceDosage-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.calculateMaintenanceDosage-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#query resource
resource "aws_api_gateway_resource" "query-resource" {
  path_part   = "query"
  parent_id   = aws_api_gateway_resource.drugbank-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "query-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.query-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "query-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.query-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "query-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.query-proxy-resource.id
  http_method             = aws_api_gateway_method.query-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.drugbankQuery-lambda-invoke_arn
}

resource "aws_lambda_permission" "query-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drugbankQuery-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.query-proxy-method.http_method}${aws_api_gateway_resource.query-proxy-resource.path}"
}

module "query-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.query-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#lotus/query resource
resource "aws_api_gateway_resource" "lotus-resource" {
  path_part   = "lotus"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "lotus-query-resource" {
  path_part   = "query"
  parent_id   = aws_api_gateway_resource.lotus-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "lotus-query-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.lotus-query-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "lotus-query-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.lotus-query-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "lotus-query-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.lotus-query-proxy-resource.id
  http_method             = aws_api_gateway_method.lotus-query-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-lotus-lambda-invoke_arn
}

resource "aws_lambda_permission" "lotus-query-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-lotus-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.lotus-query-proxy-method.http_method}${aws_api_gateway_resource.lotus-query-proxy-resource.path}"
}

module "lotus-query-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.lotus-query-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#natural-products/query resource
resource "aws_api_gateway_resource" "natural-products-resource" {
  path_part   = "natural_products"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "natural-products-query-resource" {
  path_part   = "query"
  parent_id   = aws_api_gateway_resource.natural-products-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "natural-products-query-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.natural-products-query-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "natural-products-query-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.natural-products-query-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "natural-products-query-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.natural-products-query-proxy-resource.id
  http_method             = aws_api_gateway_method.natural-products-query-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-natural-products-lambda-invoke_arn
}

resource "aws_lambda_permission" "natural-products-query-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-natural-products-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.natural-products-query-proxy-method.http_method}${aws_api_gateway_resource.natural-products-query-proxy-resource.path}"
}

module "natural-products-query-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.natural-products-query-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#xdl/upload resource
resource "aws_api_gateway_resource" "xdl-resource" {
  path_part   = "xdl"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "xdl-upload-resource" {
  path_part   = "upload"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-upload-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-upload-resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-upload-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-upload-resource.id
  http_method             = aws_api_gateway_method.xdl-upload-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-pdf-xdl-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-upload-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-pdf-xdl-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-upload-method.http_method}${aws_api_gateway_resource.xdl-upload-resource.path}"
}

module "xdl-upload-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-upload-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#xdl/add resource
resource "aws_api_gateway_resource" "xdl-add-resource" {
  path_part   = "add"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-add-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-add-resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-add-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-add-resource.id
  http_method             = aws_api_gateway_method.xdl-add-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-add-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-add-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-add-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-add-method.http_method}${aws_api_gateway_resource.xdl-add-resource.path}"
}

module "xdl-add-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-add-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#xdl/getList resource
resource "aws_api_gateway_resource" "xdl-getList-resource" {
  path_part   = "getList"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-getList-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-getList-resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-getList-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-getList-resource.id
  http_method             = aws_api_gateway_method.xdl-getList-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-get-list-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-getList-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-get-list-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-getList-method.http_method}${aws_api_gateway_resource.xdl-getList-resource.path}"
}

module "xdl-getList-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-getList-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#xdl/search resource
resource "aws_api_gateway_resource" "xdl-search-resource" {
  path_part   = "search"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-search-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-search-resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-search-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-search-resource.id
  http_method             = aws_api_gateway_method.xdl-search-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-search-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-search-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-search-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-search-method.http_method}${aws_api_gateway_resource.xdl-search-resource.path}"
}

module "xdl-search-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-search-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/xdl/changeStatus resource
resource "aws_api_gateway_resource" "xdl-changeStatus-resource" {
  path_part   = "changeStatus"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "xdl-changeStatus-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.xdl-changeStatus-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-changeStatus-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-changeStatus-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-changeStatus-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-changeStatus-proxy-resource.id
  http_method             = aws_api_gateway_method.xdl-changeStatus-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-change-status-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-changeStatus-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-change-status-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-changeStatus-proxy-method.http_method}${aws_api_gateway_resource.xdl-changeStatus-proxy-resource.path}"
}

module "xdl-changeStatus-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-changeStatus-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/xdl/getDetails resource
resource "aws_api_gateway_resource" "xdl-getDetails-resource" {
  path_part   = "getDetails"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "xdl-getDetails-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.xdl-getDetails-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-getDetails-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-getDetails-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-getDetails-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-getDetails-proxy-resource.id
  http_method             = aws_api_gateway_method.xdl-getDetails-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-get-details-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-getDetails-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-get-details-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-getDetails-proxy-method.http_method}${aws_api_gateway_resource.xdl-getDetails-proxy-resource.path}"
}

module "xdl-getDetails-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-getDetails-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/xdl/getfile resource
resource "aws_api_gateway_resource" "xdl-getfile-resource" {
  path_part   = "getfile"
  parent_id   = aws_api_gateway_resource.xdl-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "xdl-getfile-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.xdl-getfile-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "xdl-getfile-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.xdl-getfile-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "xdl-getfile-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.xdl-getfile-proxy-resource.id
  http_method             = aws_api_gateway_method.xdl-getfile-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-xdl-get-file-lambda-invoke_arn
}

resource "aws_lambda_permission" "xdl-getfile-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-xdl-get-file-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.xdl-getfile-proxy-method.http_method}${aws_api_gateway_resource.xdl-getfile-proxy-resource.path}"
}

module "xdl-getfile-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.xdl-getfile-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/3d resource
resource "aws_api_gateway_resource" "plot3d-resource" {
  path_part   = "3d"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "plot3d-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.plot3d-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "plot3d-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.plot3d-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "plot3d-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.plot3d-proxy-resource.id
  http_method             = aws_api_gateway_method.plot3d-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-plot3d-lambda-invoke_arn
}

resource "aws_lambda_permission" "plot3d-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-plot3d-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.plot3d-proxy-method.http_method}${aws_api_gateway_resource.plot3d-proxy-resource.path}"
}

module "plot3d-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.plot3d-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth resource

resource "aws_api_gateway_resource" "auth-resource" {
  path_part   = "auth"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

#/auth/forgetPasswordFirstStep resource

resource "aws_api_gateway_resource" "auth-forgetpasswordfirststep-resource" {
  path_part   = "forgetPasswordFirstStep"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-forgetpasswordfirststep-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-forgetpasswordfirststep-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.id
  http_method             = aws_api_gateway_method.auth-forgetpasswordfirststep-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-forgetpasswordfirststep-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-forgetpasswordfirststep-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-forgetpasswordfirststep-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-forgetpasswordfirststep-method.http_method}${aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-forgetpasswordfirststep-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.id
  http_method = aws_api_gateway_method.auth-forgetpasswordfirststep-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-forgetpasswordfirststep-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.id
   http_method = aws_api_gateway_method.auth-forgetpasswordfirststep-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-forgetpasswordfirststep-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-forgetpasswordfirststep-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/forgetPasswordSecondStep resource

resource "aws_api_gateway_resource" "auth-forgetpasswordsecondstep-resource" {
  path_part   = "forgetPasswordSecondStep"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-forgetpasswordsecondstep-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-forgetpasswordsecondstep-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.id
  http_method             = aws_api_gateway_method.auth-forgetpasswordsecondstep-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-forgetpasswordsecondstep-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-forgetpasswordsecondstep-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-forgetpasswordsecondstep-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-forgetpasswordsecondstep-method.http_method}${aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-forgetpasswordsecondstep-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.id
  http_method = aws_api_gateway_method.auth-forgetpasswordsecondstep-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-forgetpasswordsecondstep-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.id
   http_method = aws_api_gateway_method.auth-forgetpasswordsecondstep-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-forgetpasswordsecondstep-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-forgetpasswordsecondstep-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/login resource

resource "aws_api_gateway_resource" "auth-login-resource" {
  path_part   = "login"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-login-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-login-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-login-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-login-resource.id
  http_method             = aws_api_gateway_method.auth-login-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-login-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-login-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-login-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-login-method.http_method}${aws_api_gateway_resource.auth-login-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-login-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-login-resource.id
  http_method = aws_api_gateway_method.auth-login-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-login-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-login-resource.id
   http_method = aws_api_gateway_method.auth-login-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-login-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-login-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/refreshToken resource

resource "aws_api_gateway_resource" "auth-refreshtoken-resource" {
  path_part   = "refreshToken"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-refreshtoken-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-refreshtoken-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-refreshtoken-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-refreshtoken-resource.id
  http_method             = aws_api_gateway_method.auth-refreshtoken-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-refreshtoken-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-refreshtoken-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-refreshtoken-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-refreshtoken-method.http_method}${aws_api_gateway_resource.auth-refreshtoken-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-refreshtoken-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-refreshtoken-resource.id
  http_method = aws_api_gateway_method.auth-refreshtoken-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-refreshtoken-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-refreshtoken-resource.id
   http_method = aws_api_gateway_method.auth-refreshtoken-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-refreshtoken-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-refreshtoken-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/resendForgetPasswordCode resource

resource "aws_api_gateway_resource" "auth-resendforgetpasswordcode-resource" {
  path_part   = "resendForgetPasswordCode"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-resendforgetpasswordcode-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-resendforgetpasswordcode-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.id
  http_method             = aws_api_gateway_method.auth-resendforgetpasswordcode-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-resendforgetpasswordcode-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-resendforgetpasswordcode-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-resendforgetpasswordcode-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-resendforgetpasswordcode-method.http_method}${aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-resendforgetpasswordcode-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.id
  http_method = aws_api_gateway_method.auth-resendforgetpasswordcode-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-resendforgetpasswordcode-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.id
   http_method = aws_api_gateway_method.auth-resendforgetpasswordcode-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-resendforgetpasswordcode-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-resendforgetpasswordcode-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/resendVerificationCode resource

resource "aws_api_gateway_resource" "auth-resendverificationcode-resource" {
  path_part   = "resendVerificationCode"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-resendverificationcode-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-resendverificationcode-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-resendverificationcode-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-resendverificationcode-resource.id
  http_method             = aws_api_gateway_method.auth-resendverificationcode-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-resendverificationcode-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-resendverificationcode-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-resendverificationcode-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-resendverificationcode-method.http_method}${aws_api_gateway_resource.auth-resendverificationcode-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-resendverificationcode-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-resendverificationcode-resource.id
  http_method = aws_api_gateway_method.auth-resendverificationcode-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-resendverificationcode-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-resendverificationcode-resource.id
   http_method = aws_api_gateway_method.auth-resendverificationcode-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-resendverificationcode-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-resendverificationcode-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/verifyAccount resource

resource "aws_api_gateway_resource" "auth-verifyaccount-resource" {
  path_part   = "verifyAccount"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-verifyaccount-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-verifyaccount-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-verifyaccount-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-verifyaccount-resource.id
  http_method             = aws_api_gateway_method.auth-verifyaccount-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-verifyaccount-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-verifyaccount-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-verifyaccount-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-verifyaccount-method.http_method}${aws_api_gateway_resource.auth-verifyaccount-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-verifyaccount-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-verifyaccount-resource.id
  http_method = aws_api_gateway_method.auth-verifyaccount-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-verifyaccount-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-verifyaccount-resource.id
   http_method = aws_api_gateway_method.auth-verifyaccount-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-verifyaccount-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-verifyaccount-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/resetPasswordFirstTime resource

resource "aws_api_gateway_resource" "auth-resetpasswordfirsttime-resource" {
  path_part   = "resetPasswordFirstTime"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-resetpasswordfirsttime-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.id
  http_method   = "PUT"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-resetpasswordfirsttime-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.id
  http_method             = aws_api_gateway_method.auth-resetpasswordfirsttime-method.http_method
  integration_http_method = "PUT"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-reset-password-first-time-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-resetpasswordfirsttime-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-reset-password-first-time-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-resetpasswordfirsttime-method.http_method}${aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-resetpasswordfirsttime-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.id
  http_method = aws_api_gateway_method.auth-resetpasswordfirsttime-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-resetpasswordfirsttime-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.id
   http_method = aws_api_gateway_method.auth-resetpasswordfirsttime-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-resetpasswordfirsttime-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-resetpasswordfirsttime-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/register resource

resource "aws_api_gateway_resource" "auth-register-resource" {
  path_part   = "register"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-register-method" {
	# checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-register-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-register-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-register-resource.id
  http_method             = aws_api_gateway_method.auth-register-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-register-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-register-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-register-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-register-method.http_method}${aws_api_gateway_resource.auth-register-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-register-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-register-resource.id
  http_method = aws_api_gateway_method.auth-register-method.http_method
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-register-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-register-resource.id
   http_method = aws_api_gateway_method.auth-register-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-register-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-register-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/auth/loginWith3rdParty resource

resource "aws_api_gateway_resource" "auth-loginWith3rdParty-resource" {
  path_part   = "loginWith3rdParty"
  parent_id   = aws_api_gateway_resource.auth-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "auth-loginWith3rdParty-method" {
  # checkov:skip=CKV_AWS_59: authentication API does not require key
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.auth-loginWith3rdParty-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "auth-loginWith3rdParty-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.auth-loginWith3rdParty-resource.id
  http_method             = aws_api_gateway_method.auth-loginWith3rdParty-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-auth-loginWith3rdParty-lambda-invoke_arn
}

resource "aws_lambda_permission" "auth-loginWith3rdParty-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-auth-loginWith3rdParty-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.auth-loginWith3rdParty-method.http_method}${aws_api_gateway_resource.auth-loginWith3rdParty-resource.path}"
}

resource "aws_api_gateway_method_response" "auth-loginWith3rdParty-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.auth-loginWith3rdParty-resource.id
  http_method = aws_api_gateway_method.auth-loginWith3rdParty-method.http_method
  status_code = "200"
  response_parameters = {"method.response.header.Access-Control-Allow-Origin" = false}
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "auth-loginWith3rdParty-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.auth-loginWith3rdParty-resource.id
   http_method = aws_api_gateway_method.auth-loginWith3rdParty-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "auth-loginWith3rdParty-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.auth-loginWith3rdParty-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/profile resource

resource "aws_api_gateway_resource" "profile-resource" {
  path_part   = "profile"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

#/profile/get resource

resource "aws_api_gateway_resource" "profile-get-resource" {
  path_part   = "get"
  parent_id   = aws_api_gateway_resource.profile-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "profile-get-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.profile-get-resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "profile-get-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.profile-get-resource.id
  http_method             = aws_api_gateway_method.profile-get-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-profile-get-lambda-invoke_arn
}

resource "aws_lambda_permission" "profile-get-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-profile-get-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.profile-get-method.http_method}${aws_api_gateway_resource.profile-get-resource.path}"
}

module "profile-get-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.profile-get-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/profile/update resource

resource "aws_api_gateway_resource" "profile-update-resource" {
  path_part   = "update"
  parent_id   = aws_api_gateway_resource.profile-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "profile-update-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.profile-update-resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "profile-update-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.profile-update-resource.id
  http_method             = aws_api_gateway_method.profile-update-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-profile-update-lambda-invoke_arn
}

resource "aws_lambda_permission" "profile-update-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-profile-update-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.profile-update-method.http_method}${aws_api_gateway_resource.profile-update-resource.path}"
}

module "profile-update-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.profile-update-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/profile/changepassword resource

resource "aws_api_gateway_resource" "profile-changepassword-resource" {
  path_part   = "changePassword"
  parent_id   = aws_api_gateway_resource.profile-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "profile-changepassword-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.profile-changepassword-resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "profile-changepassword-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.profile-changepassword-resource.id
  http_method             = aws_api_gateway_method.profile-changepassword-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-profile-changepassword-lambda-invoke_arn
}

resource "aws_lambda_permission" "profile-changepassword-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-profile-changepassword-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.profile-changepassword-method.http_method}${aws_api_gateway_resource.profile-changepassword-resource.path}"
}

module "profile-changepassword-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.profile-changepassword-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement resource

resource "aws_api_gateway_resource" "usersmanagement-resource" {
  path_part   = "usersManagement"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}


#usersManagement/add resource

resource "aws_api_gateway_resource" "usersmanagement-add-resource" {
  path_part   = "add"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-add-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-add-resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-add-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-add-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-add-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-add-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-add-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-add-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-add-method.http_method}${aws_api_gateway_resource.usersmanagement-add-resource.path}"
}

resource "aws_api_gateway_method_response" "usersmanagement-add-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.usersmanagement-add-resource.id
  http_method = aws_api_gateway_method.usersmanagement-add-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "usersmanagement-add-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.usersmanagement-add-resource.id
   http_method = aws_api_gateway_method.usersmanagement-add-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}

module "usersmanagement-add-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-add-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/delete/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-delete-resource" {
  path_part   = "delete"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-delete-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-delete-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-delete-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-delete-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-delete-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-delete-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-delete-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-delete-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-delete-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-delete-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-delete-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-delete-proxy-resource.path}"
}

module "usersmanagement-delete-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-delete-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/update/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-update-resource" {
  path_part   = "update"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-update-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-update-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-update-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-update-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-update-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-update-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-update-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-update-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-update-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-update-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-update-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-update-proxy-resource.path}"
}

module "usersmanagement-update-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-update-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/details/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-details-resource" {
  path_part   = "details"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-details-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-details-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-details-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-details-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-details-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-details-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-details-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-details-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-details-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-details-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-details-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-details-proxy-resource.path}"
}

module "usersmanagement-details-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-details-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/list resource

resource "aws_api_gateway_resource" "usersmanagement-list-resource" {
  path_part   = "list"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-list-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-list-resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-list-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-list-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-list-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-list-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-list-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-list-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-list-method.http_method}${aws_api_gateway_resource.usersmanagement-list-resource.path}"
}

module "usersmanagement-list-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-list-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/deactivate/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-deactivate-resource" {
  path_part   = "deactivate"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-deactivate-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-deactivate-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-deactivate-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-deactivate-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-deactivate-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-deactivate-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-deactivate-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-deactivate-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-deactivate-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-deactivate-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-deactivate-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-deactivate-proxy-resource.path}"
}

module "usersmanagement-deactivate-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-deactivate-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/approve/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-approve-resource" {
  path_part   = "approve"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-approve-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-approve-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-approve-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-approve-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-approve-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-approve-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-approve-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-approve-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-approve-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-approve-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-approve-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-approve-proxy-resource.path}"
}

module "usersmanagement-approve-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-approve-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}

#/usersManagement/changeApiKey/{proxy} resource
resource "aws_api_gateway_resource" "usersmanagement-changeApiKey-resource" {
  path_part   = "changeApiKey"
  parent_id   = aws_api_gateway_resource.usersmanagement-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_resource" "usersmanagement-changeApiKey-proxy-resource" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.usersmanagement-changeApiKey-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "usersmanagement-changeApiKey-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.usersmanagement-changeApiKey-proxy-resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.prepaire-api.id
  api_key_required = true
}

resource "aws_api_gateway_integration" "usersmanagement-changeApiKey-proxy-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.usersmanagement-changeApiKey-proxy-resource.id
  http_method             = aws_api_gateway_method.usersmanagement-changeApiKey-proxy-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-changeApiKey-lambda-invoke_arn
}

resource "aws_lambda_permission" "usersmanagement-changeApiKey-proxy-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.backend-usersmanagement-changeApiKey-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.usersmanagement-changeApiKey-proxy-method.http_method}${aws_api_gateway_resource.usersmanagement-changeApiKey-proxy-resource.path}"
}

module "usersmanagement-changeApiKey-proxy-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.usersmanagement-changeApiKey-proxy-resource.id
  allow_headers = [
  "Authorization",
  "Content-Type",
  "X-Amz-Date",
  "X-Amz-Security-Token",
  "X-Api-Key",
  "auth"
]
}