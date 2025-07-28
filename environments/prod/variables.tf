variable "name" {
}
variable "cidr" {
}
variable "public_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "region" {
}
variable "instance_names" {
  type = list(string)
}
variable "ami_id" {
}
variable "instance_type" {
}
variable "bucket_name" {
}
variable "key_name" {
}
