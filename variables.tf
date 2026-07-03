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
  default     = "ami-12345678"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Terraform AWS Project"
    ManagedBy   = "Terraform"
    CreatedDate = "2026-07-03"
  }
}
