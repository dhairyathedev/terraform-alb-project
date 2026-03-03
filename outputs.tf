output "instance_url" {
  value = "http://${aws_instance.web_server.public_ip}"
}
