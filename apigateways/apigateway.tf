#API for model endpoints
#Datasource
data "terraform_remote_state" "lambda" {
  backend = "remote"

  config = {
    organization = "prepaire"
    workspaces = {
      name = "${var.environment}-lambda"
    }
  }
}

#Create API Gateway
resource "aws_api_gateway_rest_api" "prepaire-api" {
  name = "prepaire-models-${var.environment}"
  description = "API for prepaire backend model"
  disable_execute_api_endpoint = true
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_rest_api_policy" "prepaire-api-policy" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.prepaire-api.execution_arn}/*/*/*"
        },
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.prepaire-api.execution_arn}/*/*/*",
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp": [
                        "173.245.48.0/20",
                        "103.21.244.0/22",
                        "103.22.200.0/22",
                        "103.31.4.0/22",
                        "141.101.64.0/18",
                        "108.162.192.0/18",
                        "190.93.240.0/20",
                        "188.114.96.0/20",
                        "197.234.240.0/22",
                        "198.41.128.0/17",
                        "162.158.0.0/15",
                        "104.16.0.0/13",
                        "104.24.0.0/14",
                        "172.64.0.0/13",
                        "131.0.72.0/22"
                    ]
                }
            }
        }
    ]
}
EOF
}

#Drug interaction
resource "aws_api_gateway_resource" "drug-interaction-resource" {
  path_part   = "drug-interaction"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drug-interaction-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drug-interaction-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.drug-interaction-model.name
  }
}

resource "aws_api_gateway_integration" "drug-interaction-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drug-interaction-resource.id
  http_method             = aws_api_gateway_method.drug-interaction-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.drug-interaction-lambda-invoke_arn
}

resource "aws_lambda_permission" "drug-interaction-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drug-interaction-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drug-interaction-method.http_method}${aws_api_gateway_resource.drug-interaction-resource.path}"
}

resource "aws_api_gateway_method_response" "drug-interaction-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-interaction-resource.id
  http_method = aws_api_gateway_method.drug-interaction-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "drug-interaction-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-interaction-resource.id
  http_method = aws_api_gateway_method.drug-interaction-method.http_method
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "drug-interaction-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-interaction-resource.id
   http_method = aws_api_gateway_method.drug-interaction-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   } 
}

resource "aws_api_gateway_integration_response" "drug-interaction-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-interaction-resource.id
   http_method = aws_api_gateway_method.drug-interaction-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}

resource "aws_api_gateway_model" "drug-interaction-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "DrugInteraction"
  description  = "Drug Interaction Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Drug Interaction",
  "description": "Drug Interaction Schema",
  "type": "object",
  "properties": {
    "smile1": {
      "description": "Smile of First Drug",
      "type": "string"
    },
    "smile2": {
      "description": "Smile of Second Drug",
      "type": "string"
    }
  },
  "required": [ "smile1", "smile2"]
}
EOF
}

module "drug-interaction-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.drug-interaction-resource.id
}

#Drug Protein
resource "aws_api_gateway_resource" "drug-protein-resource" {
  path_part   = "drug-protein"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drug-protein-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drug-protein-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.drug-protein-model.name
  }
}

resource "aws_api_gateway_integration" "drug-protein-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drug-protein-resource.id
  http_method             = aws_api_gateway_method.drug-protein-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.drug-protein-lambda-invoke_arn
}

resource "aws_lambda_permission" "drug-protein-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drug-protein-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drug-protein-method.http_method}${aws_api_gateway_resource.drug-protein-resource.path}"
}

resource "aws_api_gateway_method_response" "drug-protein-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-protein-resource.id
  http_method = aws_api_gateway_method.drug-protein-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "drug-protein-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-protein-resource.id
  http_method = aws_api_gateway_method.drug-protein-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "drug-protein-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-protein-resource.id
   http_method = aws_api_gateway_method.drug-protein-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "drug-protein-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-protein-resource.id
   http_method = aws_api_gateway_method.drug-protein-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "drug-protein-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "DrugProtein"
  description  = "Drug Protein Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Drug Protein",
  "description": "Drug Protein Schema",
  "type": "object",
  "properties": {
    "protein": {
      "description": "Protein Code",
      "type": "string"
    },
    "smiles": {
      "description": "Smile code for drugs.",
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "uniqueItems": true
    }
  },
  "required": [ "protein", "smiles"]
}
EOF
}

module "drug-protein-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.drug-protein-resource.id
}

#Text2xdl
resource "aws_api_gateway_resource" "text2xdl-resource" {
  path_part   = "text-to-xdl"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "text2xdl-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.text2xdl-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.text2xdl-model.name
  }
}

resource "aws_api_gateway_integration" "text2xdl-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.text2xdl-resource.id
  http_method             = aws_api_gateway_method.text2xdl-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.text2xdl-lambda-invoke_arn
}

resource "aws_lambda_permission" "text2xdl-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.text2xdl-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.text2xdl-method.http_method}${aws_api_gateway_resource.text2xdl-resource.path}"
}

resource "aws_api_gateway_method_response" "text2xdl-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.text2xdl-resource.id
  http_method = aws_api_gateway_method.text2xdl-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "text2xdl-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.text2xdl-resource.id
  http_method = aws_api_gateway_method.text2xdl-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "text2xdl-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.text2xdl-resource.id
   http_method = aws_api_gateway_method.text2xdl-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "text2xdl-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.text2xdl-resource.id
   http_method = aws_api_gateway_method.text2xdl-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "text2xdl-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "Text2XDL"
  description  = "Text to XDL Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Text to XDL",
  "description": "Text to XDL Schema",
  "type": "object",
  "properties": {
    "input": {
      "description": "Textual Input",
      "type": "string"
    }
  },
  "required": [ "input"]
}
EOF
}

module "text2xdl-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.text2xdl-resource.id
}

#Toxicity
resource "aws_api_gateway_resource" "toxicity-resource" {
  path_part   = "toxicity"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "toxicity-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.toxicity-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.toxicity-model.name
  }
}

resource "aws_api_gateway_integration" "toxicity-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.toxicity-resource.id
  http_method             = aws_api_gateway_method.toxicity-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.toxicity-lambda-invoke_arn
}

resource "aws_lambda_permission" "toxicity-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.toxicity-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.toxicity-method.http_method}${aws_api_gateway_resource.toxicity-resource.path}"
}

resource "aws_api_gateway_method_response" "toxicity-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.toxicity-resource.id
  http_method = aws_api_gateway_method.toxicity-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "toxicity-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.toxicity-resource.id
  http_method = aws_api_gateway_method.toxicity-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "toxicity-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.toxicity-resource.id
   http_method = aws_api_gateway_method.toxicity-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "toxicity-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.toxicity-resource.id
   http_method = aws_api_gateway_method.toxicity-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "toxicity-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "Toxicity"
  description  = "Expected json schema for toxicity"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Toxicity Schema",
  "description": "Expected format",
  "type": "object",
  "properties": {
    "smiles": {
      "description": "Smile code for drugs.",
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "uniqueItems": true
    }
  },
  "required": [ "smiles" ]
}
EOF
}

module "toxicity-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.toxicity-resource.id
}

#Solubility
resource "aws_api_gateway_resource" "solubility-resource" {
  path_part   = "solubility"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "solubility-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.solubility-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.solubility-model.name
  }
}

resource "aws_api_gateway_integration" "solubility-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.solubility-resource.id
  http_method             = aws_api_gateway_method.solubility-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.solubility-lambda-invoke_arn
}

resource "aws_lambda_permission" "solubility-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.solubility-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.solubility-method.http_method}${aws_api_gateway_resource.solubility-resource.path}"
}

resource "aws_api_gateway_method_response" "solubility-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.solubility-resource.id
  http_method = aws_api_gateway_method.solubility-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "solubility-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.solubility-resource.id
  http_method = aws_api_gateway_method.solubility-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "solubility-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.solubility-resource.id
   http_method = aws_api_gateway_method.solubility-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "solubility-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.solubility-resource.id
   http_method = aws_api_gateway_method.solubility-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "solubility-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "Solubility"
  description  = "Solubility Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Solubility Schema",
  "description": "Expected format",
  "type": "object",
  "properties": {
    "smiles": {
      "description": "Smile code for drugs.",
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "uniqueItems": true
    }
  },
  "required": [ "smiles" ]
}
EOF
}

module "solubility-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.solubility-resource.id
}

#pdf-xdl
resource "aws_api_gateway_resource" "pdf-xdl-resource" {
  path_part   = "pdf-xdl"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "pdf-xdl-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.pdf-xdl-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.pdf-xdl-model.name
  }
}

resource "aws_api_gateway_integration" "pdf-xdl-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.pdf-xdl-resource.id
  http_method             = aws_api_gateway_method.pdf-xdl-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.pdf-xdl-lambda-invoke_arn
}

resource "aws_lambda_permission" "pdf-xdl-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.pdf-xdl-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.pdf-xdl-method.http_method}${aws_api_gateway_resource.pdf-xdl-resource.path}"
}

resource "aws_api_gateway_method_response" "pdf-xdl-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.pdf-xdl-resource.id
  http_method = aws_api_gateway_method.pdf-xdl-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "pdf-xdl-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.pdf-xdl-resource.id
  http_method = aws_api_gateway_method.pdf-xdl-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "pdf-xdl-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.pdf-xdl-resource.id
   http_method = aws_api_gateway_method.pdf-xdl-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "pdf-xdl-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.pdf-xdl-resource.id
   http_method = aws_api_gateway_method.pdf-xdl-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "pdf-xdl-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "Pdf2XDL"
  description  = "Pdf2XDL Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "PDF to XDL",
  "description": "PDF to XDL Schema",
  "type": "object",
  "properties": {
    "file_name": {
      "description": "Textual Input",
      "type": "string"
    }
  },
  "required": [ "file_name"]
}
EOF
}

module "pdf-xdl-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.pdf-xdl-resource.id
}

#drug-search
resource "aws_api_gateway_resource" "drug-search-resource" {
  path_part   = "drug-search"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drug-search-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drug-search-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.drug-search-model.name
  }
}

resource "aws_api_gateway_integration" "drug-search-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drug-search-resource.id
  http_method             = aws_api_gateway_method.drug-search-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.drug-search-lambda-invoke_arn
}

resource "aws_lambda_permission" "drug-search-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drug-search-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drug-search-method.http_method}${aws_api_gateway_resource.drug-search-resource.path}"
}

resource "aws_api_gateway_method_response" "drug-search-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-search-resource.id
  http_method = aws_api_gateway_method.drug-search-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method_response" "drug-search-500-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drug-search-resource.id
  http_method = aws_api_gateway_method.drug-search-method.http_method
  status_code = "500"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "drug-search-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-search-resource.id
   http_method = aws_api_gateway_method.drug-search-method.http_method
   status_code = "200"
   selection_pattern = ".*"
   response_templates = {
       "application/json" = ""
   }
}

resource "aws_api_gateway_integration_response" "drug-search-500-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drug-search-resource.id
   http_method = aws_api_gateway_method.drug-search-method.http_method
   status_code = "500"
   selection_pattern = "^Internal Error.*"
   response_templates = {
     "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "message" : "$inputRoot.errorMessage"
}
EOF
  }
}


resource "aws_api_gateway_model" "drug-search-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "DrugSearch"
  description  = "DrugSearch Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "drug": {
      "type": "string"
    },
    "filter1": {
      "type": "boolean"
    },
    "pmids": {
      "type": "boolean"
    }
  },
  "required": [
    "drug",
    "filter1",
    "pmids"
  ]
}
EOF
}

module "drug-search-cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = aws_api_gateway_rest_api.prepaire-api.id
  api_resource_id = aws_api_gateway_resource.drug-search-resource.id
}

#drugshot resource
resource "aws_api_gateway_resource" "drugshot-resource" {
  path_part   = "drugshot"
  parent_id   = aws_api_gateway_rest_api.prepaire-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

#drugshot-search
resource "aws_api_gateway_resource" "drugshot-search-resource" {
  path_part   = "search"
  parent_id   = aws_api_gateway_resource.drugshot-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drugshot-search-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drugshot-search-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.drugshot-search-model.name
  }
}

resource "aws_api_gateway_integration" "drugshot-search-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drugshot-search-resource.id
  http_method             = aws_api_gateway_method.drugshot-search-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.drugshot-search-lambda-invoke_arn
}

resource "aws_lambda_permission" "drugshot-search-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drugshot-search-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drugshot-search-method.http_method}${aws_api_gateway_resource.drugshot-search-resource.path}"
}

resource "aws_api_gateway_method_response" "drugshot-search-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drugshot-search-resource.id
  http_method = aws_api_gateway_method.drugshot-search-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "drugshot-search-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drugshot-search-resource.id
   http_method = aws_api_gateway_method.drugshot-search-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}


resource "aws_api_gateway_model" "drugshot-search-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "DrugshotSearch"
  description  = "DrugshotSearch Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "DrugShot Search",
  "description": "DrugShot Search Schema",
  "type": "object",
  "properties": {
    "rif": {
      "description": "rif",
      "type": "string"
    },
    "term": {
      "description": "term",
      "type": "string"
    }
  },
  "required": [ "rif", "term"]
}
EOF
}

#drugshot-associate
resource "aws_api_gateway_resource" "drugshot-associate-resource" {
  path_part   = "associate"
  parent_id   = aws_api_gateway_resource.drugshot-resource.id
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
}

resource "aws_api_gateway_method" "drugshot-associate-method" {
  rest_api_id   = aws_api_gateway_rest_api.prepaire-api.id
  resource_id   = aws_api_gateway_resource.drugshot-associate-resource.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
  request_models = {
     "application/json" = aws_api_gateway_model.drugshot-associate-model.name
  }
}

resource "aws_api_gateway_integration" "drugshot-associate-integration" {
  rest_api_id             = aws_api_gateway_rest_api.prepaire-api.id
  resource_id             = aws_api_gateway_resource.drugshot-associate-resource.id
  http_method             = aws_api_gateway_method.drugshot-associate-method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = data.terraform_remote_state.lambda.outputs.drugshot-associate-lambda-invoke_arn
}

resource "aws_lambda_permission" "drugshot-associate-apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.terraform_remote_state.lambda.outputs.drugshot-associate-lambda-function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:665246913124:${aws_api_gateway_rest_api.prepaire-api.id}/*/${aws_api_gateway_method.drugshot-associate-method.http_method}${aws_api_gateway_resource.drugshot-associate-resource.path}"
}

resource "aws_api_gateway_method_response" "drugshot-associate-response" {
  rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
  resource_id = aws_api_gateway_resource.drugshot-associate-resource.id
  http_method = aws_api_gateway_method.drugshot-associate-method.http_method
  status_code = "200"
  response_models = {
     "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "drugshot-associate-integration-response" {
   rest_api_id = aws_api_gateway_rest_api.prepaire-api.id
   resource_id = aws_api_gateway_resource.drugshot-associate-resource.id
   http_method = aws_api_gateway_method.drugshot-associate-method.http_method
   status_code = "200"

   response_templates = {
       "application/json" = ""
   }
}


resource "aws_api_gateway_model" "drugshot-associate-model" {
  rest_api_id  = aws_api_gateway_rest_api.prepaire-api.id
  name         = "DrugshotAssociate"
  description  = "DrugshotAssociate Schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "DrugShot Associate",
  "description": "DrugShot Associate Schema",
  "type": "object",
  "properties": {
    "similarity": {
      "description": "Similarity",
      "type": "string"
    },
    "drug_list": {
      "description": "Drug List",
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "uniqueItems": true
    }
  },
  "required": [ "similarity", "drug_list"]
} 
EOF
}