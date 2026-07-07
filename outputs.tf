output "aws_region" {
  description = "AWS region being used"
  value       = var.aws_region
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = var.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

# Security Groups Outputs
output "security_group_id" {
  description = "ID of the SSH security group"
  value       = module.security_groups.web_security_group_name
}


variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

# S3 Bucket Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_id
}
output "alb_dns_name" {
  description = "Public DNS name of the load balancer - open this in a browser"
  value       = module.alb.alb_dns_name
}
output "s3_bucket_arn" {
  description = "ARN of the S3 bucket from the S3 module"
  value       = module.s3.bucket_arn
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "s3_tracker_lambda_name" {
  description = "Name of the Lambda function tracking S3 bucket operations"
  value       = module.lambda_s3_tracker.lambda_function_name
}

output "s3_tracker_log_group" {
  description = "CloudWatch Log Group with the S3 operation logs"
  value       = module.lambda_s3_tracker.log_group_name
}

output "asg_key_pair_name" {
  description = "Name of the auto-generated key pair used by ASG instances"
  value       = module.asg.key_pair_name
}

output "asg_private_key_pem" {
  description = "Private key for SSH access to ASG instances. Retrieve with: terraform output -raw asg_private_key_pem > key.pem && chmod 400 key.pem"
  value       = module.asg.private_key_pem
  sensitive   = true
}

output "ssm_connect_hint" {
  description = "How to connect to a running ASG instance without SSH"
  value       = "aws ssm start-session --target <instance-id>   (get instance IDs via: aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${var.project_name}-${var.environment}-asg --query 'AutoScalingGroups[0].Instances[].InstanceId' --output text)"
}
