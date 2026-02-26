terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestorebusjourney"
    container_name       = "tfstate"
    key                  = "java-app.terraform.tfstate"
  }
}

