variable "project_name" {
  description = "Project name used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, staging, etc.)"
  type        = string
}

variable "s3_bucket_id" {
  description = "Bucket ID (name) of the S3 bucket to monitor"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket to monitor"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch Logs retention period in days for the Lambda's log group"
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
