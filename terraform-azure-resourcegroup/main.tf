# Manages a resource group on Azure.
terraform {
  required_version = "0.12.12"
}
resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
