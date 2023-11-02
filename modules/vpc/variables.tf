variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vpc_tenancy" {
  description = "The tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/26"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "GuardDuty"
}
