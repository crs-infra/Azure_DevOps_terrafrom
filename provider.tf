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
  use_cli = false
  
  # These will be populated from environment variables or Azure DevOps service connection:
  # ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID
  subscription_id = "ac735d05-0b35-4660-a3e3-6df6aedfe159"
}