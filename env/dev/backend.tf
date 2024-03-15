terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "dev-state/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tfstate-lock"
    role_arn       = "arn:aws:iam::00000000000:role/rolename"
  }
}
