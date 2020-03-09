output "app_service_default_hostname" {
  value = azurerm_app_service.app_service.default_site_hostname
}
output "app_service_custom_hostname" {
  value = azurerm_app_service_custom_hostname_binding.custom_name.hostname
}
output "app_service_rg_name" {
  value = azurerm_app_service.app_service.resource_group_name
}