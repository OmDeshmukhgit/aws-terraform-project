aws_region   = "ap-south-1"
environment  = "prod"
project_name = "terraform-aws-project"

vpc_cidr             = "10.1.0.0/16"
# NEW: ALB requires subnets in at least 2 AZs - a single-CIDR list will fail
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.3.0/24"]
private_subnet_cidrs = ["10.1.2.0/24", "10.1.4.0/24"]

instance_type = "t3.small"

# Left unset -> modules/asg auto-selects the latest Ubuntu 22.04 LTS AMI.
# In prod you may prefer to pin a tested AMI ID instead of always-latest:
# ami = "ami-0abcd1234..."
# ami = ""


# NEW: prod scaling - actually handle load spikes
asg_min_size               = 2
asg_max_size               = 5
asg_desired_capacity       = 2
asg_target_cpu_utilization = 60

enable_alb_https              = false # set true + provide acm_certificate_arn once you have a cert
acm_certificate_arn           = ""
s3_tracker_log_retention_days = 30

tags = {
  Project     = "Terraform AWS Project"
  ManagedBy   = "Terraform"
  CreatedDate = "2026-07-07"
  Owner       = "Om"
  Environment = "prod"
}
