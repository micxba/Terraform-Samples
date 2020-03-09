output "resourcegroup_name" {
  value = "${azurerm_resource_group.resourcegroup.name}"
}
output "resourcegroup_location" {
  value = "${azurerm_resource_group.resourcegroup.location}"
}
output "resourcegroup_id" {
  value = "${azurerm_resource_group.resourcegroup.id}"
}
output "virtualnetwork_name" {
  value = "${azurerm_virtual_network.virtualnetwork.name}"
}
output "virtualnetwork_id" {
  value = "${azurerm_virtual_network.virtualnetwork.id}"
}
output "virtualnetwork_location" {
  value = "${azurerm_virtual_network.virtualnetwork.location}"
}
output "virtualnetwork_address_space" {
  value = "${azurerm_virtual_network.virtualnetwork.address_space}"
}

