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

  allowed_ssh_cidr   = ["0.0.0.0/0"] # ⚠️ Open to world, restrict in prod
  allowed_http_cidr  = ["0.0.0.0/0"]
  allowed_https_cidr = ["0.0.0.0/0"]
}

# EC2 Module
module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  environment   = var.environment
  project_name  = var.project_name
  tags          = var.tags

  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_groups.web_security_group_id]
  key_pair_name      = "" # supply if you want SSH access

  user_data_script = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF
}

# S3 Module
module "s3" {
  source       = "./modules/s3"
  bucket_name  = "${var.project_name}-bucket-${var.environment}"
  environment  = var.environment
  project_name = var.project_name
  tags         = var.tags
}
