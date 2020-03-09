# Manages a virtual network including any configured subnets. Each subnet can optionally be configured with a security group to be associated with the subnet.
# Terraform currently provides both a standalone Subnet resource, and allows for Subnets to be defined in-line within the Virtual Network resource. At this time you cannot use a Virtual Network with in-line Subnets in conjunction with any Subnet resources. Doing so will cause a conflict of Subnet configurations and will overwrite Subnet's.

terraform {
  required_version = "0.12.12"
}
resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
  tags     = "${var.rg_tags}"
}
resource "azurerm_virtual_network" "virtualnetwork" {
  name                = "${var.vnet_name}"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  address_space       = ["${var.address_space}"]
  location            = "${var.vnet_location}"

  # Uncomment the Following Block if Ddos Protection needs to be enabled and also variable definitions in vars file and pass the values in .tfvars file
  # ddos_protection_plan {
  #    id = "${var.vnet_ddosprotectionplan_id}"
  #    enable = "${var.vnet_ddosprotectionplan_enable}"
  # }

  tags = "${var.vnet_tags}"
}
