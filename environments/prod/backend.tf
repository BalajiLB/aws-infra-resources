terraform {
  backend "s3" {
    bucket         = "my-terraform-state-prod-logabalaji"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}