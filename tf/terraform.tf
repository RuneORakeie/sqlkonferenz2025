terraform {
  backend "azurerm" {
  }
  required_version = ">= 1.8, < 2.0"
  required_providers {
    ## Azure Resource Manager
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4"
    }
    ## Microsoft Fabric 
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.9"
    }
    ## Entra ID 
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3"
    }
    ## HTTP 
    http = {
      source  = "hashicorp/http"
      version = "~> 3"
    }
    ## Microsoft Fabric REST API 
    restapi = {
      source  = "mastercard/restapi"
      version = "~> 1"
    }
  }
}

