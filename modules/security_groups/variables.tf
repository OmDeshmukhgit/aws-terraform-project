variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, staging)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "web_ingress_rules" {
  description = "Ingress rules for the web SG. SSH removed by default now that SSM Session Manager is the primary access path - add it back per-environment only if you specifically need SSH."
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    http  = { port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    https = { port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  }
}