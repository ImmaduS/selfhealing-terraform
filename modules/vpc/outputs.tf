output "vpc_id" {
  description = "VPC ID"
  value       = module.iac_vpc.vpc_attributes.id
}

output "subnet_id" {
      description = "Map of public subnet attributes grouped by az."
      value = module.iac_vpc.public_subnet_attributes_by_az.us-west-2a.id
}

output "initial_sg_id" {
    value = module.initial-security-group.security_group_id
}