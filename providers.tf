/* VPC providers */

provider "aws" {
    access_key = "Your_access_key" 
    secret_key = "Your_secret_key"
    region     = "us-east-1"
}

provider "azurerm" {
    features {}
    subscription_id = "Your_subscription_id"
    tenant_id       = "Your_tenant_id"
    client_id       = "Your_client_id"
    client_secret   = "Your_client_secret"
}

 