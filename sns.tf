resource "aws_sns_topic" "alarm_notification" {
  name         = "${aws_fsx_lustre_file_system.fsx_filesystem.id}-alarm-notification"
  display_name = "${aws_fsx_lustre_file_system.fsx_filesystem.id}-alarm-notification"
}

resource "aws_sns_topic_subscription" "alarm_email_subscription" {
  endpoint  = var.alarm_notification_email_address
  protocol  = "email"
  topic_arn = aws_sns_topic.alarm_notification.arn
}
