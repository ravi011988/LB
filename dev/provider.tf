terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a60aa6b9-597f-4824-8c46-46d7412439d3"
}