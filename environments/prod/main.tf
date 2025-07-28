module "vpc" {
  source = "git::https://github.com/BalajiLB/Terraform-Modules.git//aws/vpc?ref=v1.0.0-vpc"

  name = var.name
  cidr = var.cidr
  azs  = var.azs
  public_subnets = var.public_subnets

}

module "sg" {
  source = "git::https://github.com/BalajiLB/Terraform-Modules.git//aws/sg?ref=v1.0.1-sg"

  name   = "ec2-sg"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    for cidr in var.public_subnets : {
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = var.cidr
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ec2" {
  source        = "git::https://github.com/BalajiLB/Terraform-Modules.git//aws/ec2?ref=v1.0.0-ec2"
  count         = length(var.instance_names)
  create        = true
  name          = var.instance_names[count.index]
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[count.index]

  availability_zone           = var.azs[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  user_data                   = file("scripts/install.sh")
}

module "s3" {
  source = "git::https://github.com/BalajiLB/Terraform-Modules.git//aws/s3?ref=v1.0.0-s3"
  bucket = var.bucket_name
  versioning = {
    enabled = "true"
  }
}
