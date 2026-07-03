# Get the latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance
resource "aws_instance" "main" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_pair_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "${var.project_name}-${var.environment}-root-volume"
    }
  }

  monitoring = true
  user_data  = var.user_data_script

  associate_public_ip_address = var.enable_public_ip

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-instance"
    Environment = var.environment
    Type        = "WebServer"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}

# Key Pair (created only if none provided)
resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  count      = var.key_pair_name == "" ? 1 : 0
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = tls_private_key.main.public_key_openssh

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-key"
    Environment = var.environment
  })
}
