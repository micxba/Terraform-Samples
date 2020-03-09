output "test_portal_default_hostname" {
  value = module.test_portal.app_service_default_hostname
}
output "test_portal_custom_hostname" {
  value = module.test_portal.app_service_custom_hostname
}
output "test_portal_rg_name" {
  value = module.test_portal.app_service_rg_name
}