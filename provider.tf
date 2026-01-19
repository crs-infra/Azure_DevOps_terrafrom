terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  
  # Explicitly disable CLI authentication
  # Will use OIDC (Workload Identity Federation) from Azure DevOps service connection
  use_cli = false
  use_oidc = true
  
  # Subscription ID is specified to ensure correct subscription is used
  subscription_id = "ac735d05-0b35-4660-a3e3-6df6aedfe159"
}