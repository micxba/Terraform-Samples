output "app_plan_id" {
  value = azurerm_app_service_plan.app_plan.id
}
output "app_plan_worker_number" {
  value = azurerm_app_service_plan.app_plan.maximum_number_of_workers
}
# output "app_plan_resource_group" {
#     value = azurerm_app_service_plan.app_plan.resource_group_name
# }