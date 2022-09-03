terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "prepaire"

    workspaces {
      name = "${var.environment}"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}