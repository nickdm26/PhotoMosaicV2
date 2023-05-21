# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.57.0"
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
    always_on                               = false
    container_registry_use_managed_identity = false
    managed_pipeline_mode                   = "Integrated"
    application_stack {
      docker_image     = "${azurerm_container_registry.acr.login_server}/${var.docker_image}"
      docker_image_tag = var.docker_image_tag
    }
  }

  app_settings = {
    "DOCKER_CUSTOM_IMAGE_NAME"        = "${var.docker_image}:${var.docker_image_tag}"
    "DOCKER_ENABLE_CI"                = "true"
    "DOCKER_REGISTRY_SERVER_URL"      = azurerm_container_registry.acr.login_server
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
  }
}

resource "azurerm_container_registry_webhook" "webhook" {
  name                = "PhotoMosaicv2ContainerWebhook"
  resource_group_name = azurerm_resource_group.rg.name
  registry_name       = azurerm_container_registry.acr.name
  location            = azurerm_resource_group.rg.location

  service_uri = "https://photomosaicv2.azurewebsites.net"
  status      = "enabled"
  scope       = "${var.docker_image}:*"
  actions     = ["push"]
  custom_headers = {
    "Content-Type" = "application/json"
  }
}