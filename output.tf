/* Adding public IP of instances to the Output Values */

output "AWS_public_ip" {
  value = module.aws_grafana.webserver_ip
}

output "Azure_public_ip" {
  value = module.azure_grafana.webserver_ip
}