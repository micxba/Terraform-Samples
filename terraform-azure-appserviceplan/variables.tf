variable "app_plan_name" {
  description = "Specify the name of the App Service Plan"
}
variable "resource_group_name" {
  description = "Provide the name of the resource group where the App service plan to be created"
}
variable "location" {
  description = "Specify the location where the Plan should be created"
}
variable "app_service_environment_id" {
  description = "Provide the app service environment id"
}