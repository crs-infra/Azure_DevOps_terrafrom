terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    resource_group_name  = "eli7e-terraform-state-rg"
    storage_account_name = "eli7estorage"
    container_name       = "eli7e-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
# Yes, variables cannot be used in backend.tf files - this is a Terraform limitation