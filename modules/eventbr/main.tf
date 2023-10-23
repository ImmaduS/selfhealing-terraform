# The event bridge main file
resource "aws_cloudwatch_event_rule" "GuardDuty-Event-EC2-MaliciousIPCaller" {
  name        = "GuardDuty-Event-EC2-MaliciousIPCaller"
  description = "GuardDuty Event: UnauthorizedAccess:EC2/MaliciousIPCaller.Custom"

  event_pattern = <<EOF
{
  "source": ["aws.guardduty"],
  "detail": {
    "type": ["UnauthorizedAccess:EC2/MaliciousIPCaller.Custom"]
  }
}
 EOF
}

# EVENT TARGET RESOURCE FOR SNS NOTIFICATIONS
 resource "aws_cloudwatch_event_target" "sns" {

   rule      = aws_cloudwatch_event_rule.GuardDuty-Event-EC2-MaliciousIPCaller.name
   target_id = "GuardDuty-Example"
   arn       = var.sns_topic_arn

   input_transformer {
     input_paths = {
       gdid     = "$.detail.id",
       region   = "$.detail.region",
       instanceid = "$.detail.resource.instanceDetails.instanceId"
     }
     input_template = "\"First GuardDuty Finding for the GuardDuty-IAC tutorial. | ID:<gdid> | The EC2 instance: <instanceid>, may be compromised and should be investigated. Go to https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?macros=current&fId=<gdid>\""
   }
 }


 # EVENT RULE RESOURCE
 resource "aws_cloudwatch_event_rule" "GuardDuty-Event-IAMUser-MaliciousIPCaller" {
   name        = "GuardDuty-Event-IAMUser-MaliciousIPCaller"
   description = "GuardDuty Event: UnauthorizedAccess:IAMUser/MaliciousIPCaller.Custom"
   event_pattern = <<EOF
 {
   "source": ["aws.guardduty"],
   "detail": {
     "type": ["UnauthorizedAccess:IAMUser/MaliciousIPCaller.Custom", "Discovery:S3/MaliciousIPCaller.Custom"]
   }
 }
 EOF
 }

 #EVENT TARGET RESOURCE FOR SNS NOTIFICATIONS
 resource "aws_cloudwatch_event_target" "iam-sns" {

   rule      = aws_cloudwatch_event_rule.GuardDuty-Event-IAMUser-MaliciousIPCaller.name
   target_id = "GuardDuty-Example"
   arn       = var.sns_topic_arn

   input_transformer {
     input_paths = {
       gdid     = "$.detail.id",
       region   = "$.detail.region",
       userName = "$.detail.resource.accessKeyDetails.userName"
     } 
     input_template = "\"Second GuardDuty Finding for the GuardDuty-IAC tutorial. | ID:<gdid> | AWS Region:<region>. An AWS API operation was invoked (userName: <userName>) from an IP address that is included on your threat list and should be investigated.Go to https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?macros=current&fId=<gdid>\""
   }
 }
