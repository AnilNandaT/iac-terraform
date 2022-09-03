resource "aws_api_gateway_authorizer" "prepaire-api" {
  name                   = "authorizer"
  rest_api_id            = aws_api_gateway_rest_api.prepaire-api.id
  authorizer_uri         = data.terraform_remote_state.lambda.outputs.api-authoriser-lambda-invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
  type = "REQUEST"
  identity_source = "method.request.header.auth"
}

resource "aws_iam_role" "invocation_role" {
  name = "prepaire-${var.environment}-api-gateway-auth-invocation"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "prepaire-${var.environment}-api-gateway-auth-invocation-policy"
  role = aws_iam_role.invocation_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${data.terraform_remote_state.lambda.outputs.api-authoriser-lambda-arn}"
    }
  ]
}
EOF
}