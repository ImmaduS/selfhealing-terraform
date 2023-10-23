# The VPC output variables.

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
 description = "Output of s3 bucket id."
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
  description = "Output of the s3 bucket arn."
}