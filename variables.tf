variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name (dev, prod, staging, etc.)"
  type        = string

  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "Environment must be 'dev', 'prod', or 'staging'."
  }
}

variable "project_name" {
  description = "Project name to be used as a prefix for resource names"
  type        = string
  default     = "terraform-aws-project"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type (free tier: t2.micro)"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-01a00762f46d584a1"
}


variable "web_ingress_rules" {
  description = "Ingress rules for web security group"

  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    ssh   = { port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    http  = { port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    https = { port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Terraform AWS Project"
    ManagedBy   = "Terraform"
    CreatedDate = "2026-07-07"
  }
}
variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_target_cpu_utilization" {
  description = "Target average CPU utilization (%) that drives ASG scaling"
  type        = number
  default     = 60
}

variable "enable_alb_https" {
  description = "Whether to create an HTTPS listener on the ALB (requires acm_certificate_arn)"
  type        = bool
  default     = false
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the ALB HTTPS listener"
  type        = string
  default     = ""
}

variable "s3_tracker_log_retention_days" {
  description = "CloudWatch Logs retention (days) for the S3-tracking Lambda"
  type        = number
  default     = 14
}
