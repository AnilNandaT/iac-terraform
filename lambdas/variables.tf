variable "environment" {
    type = string
    description = "The environment value to be added in resource names"
}

variable "db_connection_string" {
  type = string
  description = "db connection string"
  sensitive = true
}

variable "access_token_private" {
  type = string
  description = "private access token"
  sensitive = true
}

variable "access_token_public" {
  type = string
  description = "public access token"
  sensitive = true
}

variable "refresh_token_private" {
  type = string
  description = "private refresh token"
  sensitive = true
}

variable "refresh_token_public" {
  type = string
  description = "public refresh token"
  sensitive = true
}


variable "reset_pass_token_private" {
  type = string
  description = "private reset pass token"
  sensitive = true
}

variable "reset_pass_token_public" {
  type = string
  description = "public reset pass token"
  sensitive = true
}