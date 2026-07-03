aws_region   = "ap-south-1"
environment  = "prod"
project_name = "terraform-aws-project"

vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24"]
private_subnet_cidrs = ["10.1.2.0/24"]

instance_type = "t3.small"

tags = {
  Project     = "Terraform AWS Project"
  ManagedBy   = "Terraform"
  CreatedDate = "2026-04-14"
  Owner       = "Om"
  Environment = "prod"
}
