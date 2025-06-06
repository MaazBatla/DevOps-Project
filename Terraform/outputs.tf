output "load_balancer_dns" {
  value = aws_lb.app_lb.dns_name
}

output "mysql_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}