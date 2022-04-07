terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "shared-services"
    storage_account_name = "tomasiac"
    container_name       = "tfstate"
    key                  = "project1-prod.tfstate"
    subscription_id      = "a0f4a733-4fce-4d49-b8a8-d30541fc1b45"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
      template_deployment {
        delete_nested_items_during_deletion = false
      }
    }
  }
}
