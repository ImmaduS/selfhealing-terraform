# To create the SNS topic

resource "aws_sns_topic" "gd_sn_topic" {
  name = var.sns_name
}