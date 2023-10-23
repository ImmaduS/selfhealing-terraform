# To get the current aws account number
data "aws_caller_identity" "current"{

}

# Create an S3 bucket
resource "aws_s3_bucket" "bucket"{
bucket = "guardduty-exemple-${data.aws_caller_identity.current.account_id}-us-east-1"
force_destroy = true

}

# VPC flow logs
resource "aws_flow_log" "aws_flow_log_exemple" {
    log_destination = aws_s3_bucket.bucket.arn
    log_destination_type = "s3"
    traffic_type = "ALL"
    vpc_id = var.vpc_id
}