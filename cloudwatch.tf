resource "aws_cloudwatch_dashboard" "fsx_filesystem_dashboard" {
  dashboard_name = join("-", [var.name, var.region])
  dashboard_body = templatefile("${path.module}/assets/fsx-dashboard.tftpl", {
    accountId    = data.aws_caller_identity.current.account_id,
    alarmArn     = aws_cloudwatch_metric_alarm.fsx_storage_capacity_alarm.arn
    fileSystemId = aws_fsx_lustre_file_system.fsx_filesystem.id,
    name         = var.name
    region       = var.region
  })
}

resource "aws_cloudwatch_metric_alarm" "fsx_storage_capacity_alarm" {
  alarm_name          = "low-free-storage-capacity-alarm-${aws_fsx_lustre_file_system.fsx_filesystem.id}"
  alarm_actions       = [aws_sns_topic.alarm_notification.arn]
  alarm_description   = "Low free storage capacity alarm for ${aws_fsx_lustre_file_system.fsx_filesystem.id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.enable_low_storage_capacity_alarm ? 1 : 0
  metric_name         = "FreeDataStorageCapacity"
  namespace           = "AWS/FSx"
  period              = 60
  statistic           = "Sum"
  threshold           = var.low_free_data_storage_capacity_threshold
  treat_missing_data  = "missing"

  dimensions = {
    FileSystemId = aws_fsx_lustre_file_system.fsx_filesystem.arn
  }
}
