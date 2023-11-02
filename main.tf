# To Create VPC
 module "vpc" {
  source ="./modules/vpc"
  
 } 
 # Get the lastest AMI and is used in the creation of ec2
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
# Create iam

  module "iam" {
    source = "./modules/iam"
  }
# Create an s3 bucket
  module "s3" {
    source ="./modules/s3"
    vpc_id = module.iac_vpc.vpc_attributes.id   
  }

# Create guardduty 
  module "guardduty"{
    source = "./guardduty"
    bucket = module.s3_bucket.bucket_id
    malicious_ip = module.compute.malicious_ip
  }
# Create a event bridge
module "guardduty_eventbridge_rule" {
  source                          = "./modules/eventbridge"
  sns_topic_arn                   = module.guardduty_sns_topic.sns_topic_arn
  lambda_remediation_function_arn = module.lambda.lambda_remediation_function_arn
}

# Create a Lambda function
module "lambda" {
  source                  = "./modules/lambda"
  sns_topic_arn           = module.guardduty_sns_topic.sns_topic_arn
  compromised_instance_id = module.compute.compromised_instance_id
  forensic_sg_id          = module.forensic-security-group.security_group_id
}