# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment          = var.environment
  project_name         = var.project_name
  tags                 = var.tags
}


# Security Groups Module
module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name
  tags         = var.tags
  web_ingress_rules = var.web_ingress_rules

}

# S3 Module
module "s3" {
  source       = "./modules/s3"
  bucket_name  = "${var.project_name}-bucket-${var.environment}"
  environment  = var.environment
  project_name = var.project_name
  tags         = var.tags
}

#alb module
module "alb" {
  source = "./modules/alb"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  target_port        = 80
  health_check_path  = "/"
  allowed_http_cidr  = ["0.0.0.0/0"]
  allowed_https_cidr = ["0.0.0.0/0"]

  enable_https    = var.enable_alb_https
  certificate_arn = var.acm_certificate_arn
}

#ASG module
module "asg" {
  source = "./modules/asg"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags

  ami           = var.ami
  instance_type = var.instance_type

  security_group_ids = [module.security_groups.web_security_group_id]
  subnet_ids         = module.vpc.public_subnet_ids
  target_group_arns  = [module.alb.target_group_arn]

  user_data_script = <<-EOF
  #!/bin/bash
  apt-get update -y
  apt-get install -y nginx
  systemctl start nginx
  systemctl enable nginx
  EOF

  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_capacity
  target_cpu_utilization = var.asg_target_cpu_utilization
}


module "lambda_s3_tracker" {
  source = "./modules/lambda_s3_tracker"

  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags

  s3_bucket_id  = module.s3.bucket_id
  s3_bucket_arn = module.s3.bucket_arn

  log_retention_days = var.s3_tracker_log_retention_days
}
