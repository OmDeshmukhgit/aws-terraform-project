output "web_security_group_id" {
  description = "ID of the web security group"
  value       = aws_security_group.web_security_group_name.id
}

output "web_security_group_name" {
  description = "Name of the web security group"
  value       = aws_security_group.web_security_group_name.id
}

output "database_security_group_id" {
  description = "ID of the database security group"
  value       = aws_security_group.database.id
}

output "database_security_group_name" {
  description = "Name of the database security group"
  value       = aws_security_group.database.name
}
