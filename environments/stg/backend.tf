terraform {
  backend "s3" {
    bucket         = "my-terraform-state-stage-logabalaji"
    key            = "stage/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}