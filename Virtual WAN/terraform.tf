terraform {
  required_version = "~> 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
    subscription_id = "f8bf7adc-eeed-4320-b9e4-b30e582ef115"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}