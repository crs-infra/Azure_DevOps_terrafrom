terraform {
  backend "azurerm" {
    # Disable CLI, use environment variables from Azure DevOps service connection
    # The Terraform task will set ARM_CLIENT_ID, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID
    # and either ARM_OIDC_TOKEN or ARM_CLIENT_SECRET
    use_cli              = false
    resource_group_name  = "eli7e-terraform-state-rg"
    storage_account_name = "eli7estorage"
    container_name       = "eli7e-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
# Yes, variables cannot be used in backend.tf files - this is a Terraform limitation