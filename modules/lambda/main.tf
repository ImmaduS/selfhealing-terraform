# lamba funtion to trigger action
data "aws_iam_policy_document" "" {
  statement {
    effect = "Allow"
    action =["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
  }
}
resource "aws_iam_role_policy" "GD-EC2MaliciousIPCaller-inline-role-policy" {
  name = "GD-EC2MaliciousIPCaller-inline-role-policy"
  role = aws_iam_role.GD-Lambda-EC2MaliciousIPCaller-role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ssm:PutParameter",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:DescribeInstances",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:DescribeVpcs",
          "ec2:ModifyInstanceAttribute",
          "lambda:InvokeFunction",
          "cloudwatch:PutMetricData",
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "logs:*"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "sns:Publish"
        ],
        "Resource" : var.sns_topic_arn,
        "Effect" : "Allow"
      }      
    ]
  })
}

resource "aws_iam_role" "GD-Lambda-EC2MaliciousIPCaller-role" {
  name               = "GD-Lambda-EC2MaliciousIPCaller-role1"
  assume_role_policy = data.aws_iam_policy_document.GD-EC2MaliciousIPCaller-policy-document.json
}