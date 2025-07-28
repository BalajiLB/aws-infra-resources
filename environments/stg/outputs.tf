output "public_subnets" {
  value = module.vpc.public_subnets
}
output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}
output "public_network_acl_id" {
  value = module.vpc.public_network_acl_id
}
output "s3_bucket_id" {
  value = module.s3.s3_bucket_id
}
output "s3_bucket_arn" {
  value = module.s3.s3_bucket_arn
}
output "s3_directory_bucket_name" {
  value = module.s3.s3_directory_bucket_name
}
