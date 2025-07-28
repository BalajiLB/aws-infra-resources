terraform {
  backend "s3" {
    bucket         = "my-terraform-state-stage-logabalaji"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}