/* Terraform main file */

module "aws_grafana" {
  source = "./modules/aws" 
}

module "azure_grafana" {
  source = "./modules/azure"
}
