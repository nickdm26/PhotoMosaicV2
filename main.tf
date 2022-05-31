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
  tags     = var.tag
}

resource "azurerm_container_registry" "acr" {
  name                = "PhotoMosaicV2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_enabled       = true
  sku                 = "Basic"
  tags                = var.tag
}

resource "azurerm_service_plan" "asp" {
  name                = "ASP-PhotoMosaicV2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = var.tag
}

resource "azurerm_linux_web_app" "alwa" {
  name                    = "PhotoMosaicV2"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  service_plan_id         = azurerm_service_plan.asp.id
  tags                    = var.tag
  client_affinity_enabled = true
  client_certificate_mode = "Required"
  site_config {
    always_on = false
    application_stack {
      docker_image     = "photomosaicv2.azurecr.io/photomosaicv2"
      docker_image_tag = "latest"
    }
  }

}