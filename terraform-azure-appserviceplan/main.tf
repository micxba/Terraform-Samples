terraform {
  required_version = "0.12.17"
  backend "azurerm" {}
}
resource azurerm_app_service_plan "app_plan" {
  name                = var.app_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "Windows"
  sku {
    tier = "Isolated"
    size = "I1"
    # capacity is required field though not mentioned in the documentation, it is the no of workers field
    capacity = "1"
  }
  app_service_environment_id = var.app_service_environment_id
}