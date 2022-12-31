output "webserver_ip" {
  value = aws_instance.grafana_webserver_instance.public_ip
}