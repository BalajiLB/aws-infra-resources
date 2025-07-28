name                = "dev-vpc"
cidr                = "10.0.0.0/16"
public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
azs                 = ["us-west-2a", "us-west-2b"]
region              = "us-west-2"
instance_names      = ["dev-web-app1", "dev-web-app2"]
ami_id              = "ami-03b322c510c7cf8e3"
instance_type       = "t2.micro"
bucket_name         = "dev-s3-loga-bucket"

