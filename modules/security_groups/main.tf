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

locals {
  web_ingress_flat = merge([
    for rule_name, rule in var.web_ingress_rules : {
      for idx, cidr in rule.cidr_blocks :
      "${rule_name}-${idx}" => {
        port     = rule.port
        protocol = rule.protocol
        cidr     = cidr
      }
    }
  ]...)
}

resource "aws_vpc_security_group_ingress_rule" "web" {
  for_each          = local.web_ingress_flat
  security_group_id = aws_security_group.web_security_group_name.id
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr
  description       = each.key
}

# Outbound Rule for Web SG
resource "aws_vpc_security_group_egress_rule" "web_allow_all" {
  security_group_id = aws_security_group.web_security_group_name.id
  description        = "Allow all outbound traffic"
  ip_protocol        = "-1" 
  cidr_ipv4          = "0.0.0.0/0"
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
  ip_protocol       = "-1" 
  cidr_ipv4         = "0.0.0.0/0"
}