aws_region   = "ap-south-1"
environment  = "dev"
project_name = "terraform-aws-project"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]

instance_type = "t3.micro"

asg_min_size               = 1
asg_max_size               = 2
asg_desired_capacity       = 1
asg_target_cpu_utilization = 70

enable_alb_https              = false
acm_certificate_arn           = ""
s3_tracker_log_retention_days = 14

tags = {
  Project     = "Terraform AWS Project"
  ManagedBy   = "Terraform"
  CreatedDate = "2026-07-07"
  Owner       = "Om"
  Environment = "dev"
}