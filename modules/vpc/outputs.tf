output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets, in the same order as var.public_subnet_cidrs"
  value       = [for cidr in var.public_subnet_cidrs : aws_subnet.public[cidr].id]
}

output "private_subnet_ids" {
  description = "IDs of private subnets, in the same order as var.private_subnet_cidrs"
  value       = [for cidr in var.private_subnet_cidrs : aws_subnet.private[cidr].id]
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}
