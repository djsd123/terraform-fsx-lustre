variable "name" {
  type        = string
  description = "Common name for all resources"

  default = "fsx-example"
}

variable "region" {
  type = string
}

variable "fsx_s3_import_path" {
  type        = string
  description = "The s3 bucket to use to back your fsx filesystem. Defaults to NASA's nex open data bucket"

  default = "s3://nasanex"
}

variable "fsx_storage_capacity" {
  type        = number
  description = "Storage capacity of file system in increments of 3600 GiBs"

  default = 7200
}

variable "alarm_notification_email_address" {
  type        = string
  description = "The email address to send FSX storage alarms/alerts to"
}

variable "enable_low_storage_capacity_alarm" {
  type        = bool
  description = "Whether to enable the 'Low free storage capacity alarm'?"

  default = false
}

variable "low_free_data_storage_capacity_threshold" {
  type        = string
  description = "Low free data storage capacity threshold (Bytes)"

  default = "7100000000000"

  validation {
    condition     = length(regexall("^[0-9]+$", var.low_free_data_storage_capacity_threshold)) == 1
    error_message = "Value must contain number only as a string"
  }
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the fsx instance"

  default = "c5.4xlarge"
}
