output "instance_url" {
  value = "http://${aws_instance.web_server.public_ip}"
}

output "alb_endpoint_url" {
  value = aws_alb.web_alb.dns_name
}
