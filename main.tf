terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = "rg-${var.nom_prenom}-${random_integer.unique_id.result}"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "my_app_service_plan" {
  name                = "asp-${var.nom_prenom}-${random_integer.unique_id.result}"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "my_web_app" {
  name                = "webapp-${var.nom_prenom}-${random_integer.unique_id.result}"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  site_config {
    java_version           = "1.8"
    java_container         = "TOMCAT"
    java_container_version = "9.0"
  }
}

variable "nom_prenom" {
  description = "Nom et prénom pour générer les noms des ressources"
}

variable "random_integer" {
  description 
