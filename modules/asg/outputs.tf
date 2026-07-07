output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}

output "launch_template_id" {
  description = "ID of the launch template used by the ASG"
  value       = aws_launch_template.this.id
}

output "key_pair_name" {
  description = "Name of the key pair attached to instances (generated or bring-your-own)"
  value       = var.create_key_pair ? aws_key_pair.this[0].key_name : var.key_pair_name
}

output "private_key_pem" {
  description = "PEM-encoded private key for SSH access. Only populated when create_key_pair = true. Retrieve with: terraform output -raw private_key_pem > key.pem && chmod 400 key.pem"
  value       = var.create_key_pair ? tls_private_key.this[0].private_key_pem : null
  sensitive   = true
}

output "ssm_role_arn" {
  description = "ARN of the IAM role instances use for SSM Session Manager access. Null if enable_ssm = false."
  value       = var.enable_ssm ? aws_iam_role.ssm[0].arn : null
}
