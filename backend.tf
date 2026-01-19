terraform {
  backend "azurerm" {
    # Use service principal authentication (from ARM_* env vars)
    # Set use_azuread_auth = false to use access key from env: ARM_ACCESS_KEY
    use_azuread_auth     = false
    use_cli              = false
    resource_group_name  = "eli7e-terraform-state-rg"
    storage_account_name = "eli7estorage"
    container_name       = "eli7e-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
# Yes, variables cannot be used in backend.tf files - this is a Terraform limitation