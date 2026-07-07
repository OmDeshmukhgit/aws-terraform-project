output "lambda_function_name" {
  description = "Name of the S3 tracker Lambda function"
  value       = aws_lambda_function.s3_tracker.function_name
}

output "lambda_function_arn" {
  description = "ARN of the S3 tracker Lambda function"
  value       = aws_lambda_function.s3_tracker.arn
}

output "log_group_name" {
  description = "CloudWatch Log Group where tracked S3 events are written"
  value       = aws_cloudwatch_log_group.lambda.name
}
