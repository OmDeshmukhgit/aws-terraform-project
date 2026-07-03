# Web Security Group
resource "aws_security_group" "web_security_group_name" {
  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Security group for web servers"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-web-sg"
    Environment = var.environment
    Type        = "Web"
  })
}

# Inbound Rules for Web SG
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web_security_group_name.id
  description       = "SSH access from allowed CIDRs"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_ssh_cidr[0]
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_security_group_name.id
  description       = "HTTP access from internet"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_http_cidr[0]
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.web_security_group_name.id
  description       = "HTTPS access from internet"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_https_cidr[0]
}

# Outbound Rule for Web SG
resource "aws_vpc_security_group_egress_rule" "web_allow_all" {
  security_group_id = aws_security_group.web_security_group_name.id
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Database Security Group
resource "aws_security_group" "database" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "Security group for databases (private)"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name        = "${var.project_name}-${var.environment}-db-sg"
    Environment = var.environment
    Type        = "Database"
  })
}

# Inbound Rule: MySQL from Web SG only
resource "aws_vpc_security_group_ingress_rule" "mysql_from_web" {
  security_group_id            = aws_security_group.database.id
  description                  = "MySQL access from web servers only"
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.web_security_group_name.id
}

# Outbound Rule for Database SG
resource "aws_vpc_security_group_egress_rule" "db_allow_all" {
  security_group_id = aws_security_group.database.id
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}
