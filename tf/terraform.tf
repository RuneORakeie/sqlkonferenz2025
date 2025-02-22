terraform {
  backend "azurerm" {
    resource_group_name  = "ClauseFabric"
    storage_account_name = "tfsamsfabrictfstate"
    container_name       = "tfstate"
    key                  = "terraform-msfabric.tfstate"
    use_oidc             = true
  }
  required_version = ">= 1.8, < 2.0"
  required_providers {
    ## Azure Resource Manager
    azurerm = {
      source = "hashicorp/azurerm"
    }
    ## Microsoft Fabric 
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.9"
    }
    ## Entra ID 
    azuread = {
      source = "hashicorp/azuread"
    }
    ## Microsoft Fabric REST API 
    restapi = {
      source = "mastercard/restapi"
      # version = "~> 1"
    }
  }
}

/*
terraform init \
  -backend-config="resource_group_name=ClauseFabric" \
  -backend-config="storage_account_name=tfsamsfabrictfstate" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform-msfabric.tfstate"
*/
