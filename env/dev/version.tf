terraform {
  required_version = "~> 1.3"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.16.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.51.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.3"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.3.0"
    }
  }
}
provider "aws" {
  alias  = "prod_central"
  region = "eu-central-1"
}
provider "aws" {
  alias  = "prod_west"
  region = "us-east-1"
}
