# To enables confifurations for the gaurd duty:
resource " aws_guardduty_detector" "gd-tutorial" {
  enable = true
  finding_publishing_frequency = "TWENTY_MINUTES"
}


#
resource "aws_s3_object" "threatintelset" {
  content = var.malicious_ip
  bucket = var.bucket
  key = "threatintelset"

}

resource "aws_guardduty_threatintelset" "name" {
  
  activate = true
  detector_id = aws_guardduty_detector.gd-tutorial.id
  format = "TXT"
  location = "https://s3.amazonaws.com/{aws_s3_object.MyThreatIntetlset.bucket}/${aws_s3_object.MythreatIntelSet}"
  name =  "MyThreatIntelSet"
}