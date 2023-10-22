# To Crete VPC
 module "vpc" {
   source ="./modules/vpc"
   cidr_block = "10.0.0.0/24"
   tenancy ="default"
   sunet_cidr = "10.0.0.0/26"
    vpc_name =  "GuardDutry"
 }

 # To get the lastest AMI resiurce and is used in the creation of ec2
  data "aws_ami" "latest_amazonlinux_ami"{
    most_recent = true
    owners = ["amazon"]

    filter {
        name ="name"
        values = ["amazn2-ami-hvm-*-gp2"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
  
  }
  # create modules

  module "iam" {
    source = "./iam"
  }

  module "s3" {
    source ="./modules/s3"
    vpc_id = module.iac_vpc.vpc_attributes.id   
  }
  module "guardduty"{
    source = "./guardduty"
    bucket = module.s3_bucket.bucket_id
    malicious_ip = module.compute.malicious_ip
  }
