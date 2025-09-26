output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion.public_ip
}
output "load_balancer_url" {
  description = "Complete URL to access the load balancer"
  value       = "http://${aws_lb.app_alb.dns_name}"
}
