variable "project_name" {
  description = "Project name used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, staging, etc.)"
  type        = string
}

variable "ami" {
  description = "AMI ID for the launch template. Leave blank (\"\") to auto-select the latest Ubuntu 22.04 LTS AMI for the current region."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type for the launch template"
  type        = string
}

variable "create_key_pair" {
  description = "If true (default), Terraform generates an RSA key pair automatically and uses it for the launch template - no manual console step needed. Set to false and supply key_pair_name to bring your own existing key pair instead."
  type        = bool
  default     = true
}

variable "key_pair_name" {
  description = "Name of an EXISTING key pair to use instead of generating one. Only used when create_key_pair = false. Leave blank for no SSH access at all when create_key_pair = false."
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "Security group IDs to attach to the instances (e.g. the web SG)"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnet IDs the ASG will launch instances into (public subnets in this project)"
  type        = list(string)
}

variable "target_group_arns" {
  description = "ALB target group ARN(s) to attach instances to"
  type        = list(string)
  default     = []
}

variable "user_data_script" {
  description = "Raw user-data script (bash) run on instance boot"
  type        = string
  default     = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "target_cpu_utilization" {
  description = "Target average CPU utilization (%) for the scaling policy"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}


variable "enable_ssm" {
  description = "If true (default), attaches an IAM instance profile with AmazonSSMManagedInstanceCore so you can connect via `aws ssm start-session` - no SSH key, no open port 22 needed."
  type        = bool
  default     = true
}
