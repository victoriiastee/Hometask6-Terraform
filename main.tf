/* Terraform main file */

module "aws_grafana" {
  source = "./aws" 
}

module "azure_grafana" {
  source = "./azure"
}
