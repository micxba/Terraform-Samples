variable "app_service_name" {
  description = "Provide the name of the app service"
}
variable "resource_group_name" {
  description = "Provide the name of the resource group where the App service plan to be created"
}
variable "app_service_plan_id" {
  description = "Provide the app service plan id"
}
variable "domain_name" {
  description = "provide the domain name"
}
variable "gateway_name" {
  description = "Provide the Application Gateway name"
}
variable "gateway_resource_group_name" {
  description = "Provide the name of the resource group where the App gateway is"
}
variable "frontend_port" {
  description = "Provide the Front End Port for configuring webapp with the application gateway"
}
variable "http_setting" {
  description = "Provide the http setting to be used for this web app backend"
}