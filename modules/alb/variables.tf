variable "project_name" {
  description = "Project name used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, staging, etc.)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and its security group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to place the ALB in"
  type        = list(string)
}

variable "target_port" {
  description = "Port on the EC2 instances / ASG targets that the ALB forwards traffic to"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path used by the target group health check"
  type        = string
  default     = "/"
}

variable "allowed_http_cidr" {
  description = "CIDR blocks allowed to reach the ALB on HTTP (80)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_https_cidr" {
  description = "CIDR blocks allowed to reach the ALB on HTTPS (443)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_https" {
  description = "Whether to create an HTTPS (443) listener. Requires certificate_arn."
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener (required if enable_https = true)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
