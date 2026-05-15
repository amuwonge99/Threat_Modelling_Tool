output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "domain_name" {
  value       = var.domain_name
  description = "Application domain name"
}

output "container_image" {
  value       = var.container_image
  description = "Docker image for the ECS service"
}