variable "function_name" {
  type = string
  description = "Function name for lambda"
}

variable "iam_role" {
    type = string
    description = "IAM role for lambda function"
}

variable "lambda_s3_bucket" {
  type = string
  description = "s3 bucket name for lambda function"
}

variable "lambda_s3_artifact" {
  type = string
  description = "s3 object for latest lambda artifact"
}

variable "timeout" {
  type = number
  description = "lambda timeout value"
  default = 3
}

variable "subnets" {
    type = list(string)
    description = "List of subnets for lambda function"
}

variable "security_group" {
    type = list(string)
    description = "List of security group for lambda function"
  
}

variable "lambda_layer" {
  type = list(string)
    description = "List of layers for lambda function"
}