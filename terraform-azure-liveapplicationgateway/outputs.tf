output "gateway_subnet_id" {
  value = azurerm_subnet.gateway_subnet.id
}
output "gateway_subnet_name" {
  value = azurerm_subnet.gateway_subnet.name
}
output "gateway_subnet_virtualnetwork_name" {
  value = azurerm_subnet.gateway_subnet.virtual_network_name
}
output "gateway_subnet_address_prefix" {
  value = azurerm_subnet.gateway_subnet.address_prefix
}
output "gateway_publicip_ip_address" {
  value = azurerm_public_ip.gateway_public_ip.ip_address
}