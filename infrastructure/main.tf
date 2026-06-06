terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Update storage_account_name with the value from: cd bootstrap && terraform output storage_account_name
  backend "azurerm" {
    resource_group_name  = "myapp-tfstate-rg"
    storage_account_name = "REPLACE_WITH_BOOTSTRAP_OUTPUT"
    container_name       = "tfstate"
    key                  = "myapp.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azuread" {}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-rg"
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}
