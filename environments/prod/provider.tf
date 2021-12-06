terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "tomuvstore"
    container_name       = "tf-project1"
    key                  = "prod.terraform.tfstate"
    use_azuread_auth     = true
    subscription_id      = "a0f4a733-4fce-4d49-b8a8-d30541fc1b45"
  }
}

provider "azurerm" {
  features {}
}
