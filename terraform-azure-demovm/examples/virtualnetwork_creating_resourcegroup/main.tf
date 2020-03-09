# This resource is provisioned to generate random id and attach to the name of Resource Group to ensure uniqueness of name
resource "random_id" "randomid" {
  byte_length = 2
}

resource "azurerm_resource_group" "test_resourcegroup" {
  name     = "${var.product}_${var.component}_${var.environment}_${random_id.randomid.hex}"
  location = var.rg_location
  tags     = var.rg_tags
}

module "test_virtualnetwork" {
  source             = "../../"
  vnet_name          = "${var.product}_${var.environment}_vnet_${random_id.randomid.hex}"
  resource_group_name = azurerm_resource_group.test_resourcegroup.name
  address_space      = var.address_space
  location      = var.location
  vnet_tags          = var.vnet_tags
}

