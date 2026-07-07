variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, staging, etc.)"
  type        = string
}

variable "project_name" {
  description = "Project name used as a prefix for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for ASG instances"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2/ASG instances (optional, defaults to latest Ubuntu 22.04 LTS if unset)"
  type        = string
  default     = ""
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
}

variable "asg_min_size" {
  description = "Minimum number of instances in Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum number of instances in Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in Auto Scaling Group"
  type        = number
}

variable "asg_target_cpu_utilization" {
  description = "Target average CPU utilization for ASG scaling policy"
  type        = number
}

variable "enable_alb_https" {
  description = "Enable HTTPS listener on ALB"
  type        = bool
  default     = false
}

variable "acm_certificate_arn" {
  description = "ARN of ACM certificate for ALB HTTPS"
  type        = string
  default     = ""
}

variable "s3_tracker_log_retention_days" {
  description = "Number of days to retain CloudWatch logs for Lambda S3 tracker"
  type        = number
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
