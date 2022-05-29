# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  cloud {
    organization = "nickdm26"
    workspaces {
      name = "PhotoMosaicV2"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Project    = "PhotoMosaicV2"
    Enviroment = "Test"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "PhotoMosaicV2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  tags = {
    Project    = "PhotoMosaicV2"
    Enviroment = "Test"
  }
}