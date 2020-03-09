terraform {
  required_version = "0.12.17"
  backend "azurerm" {}
}
resource azurerm_app_service "app_service" {
  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = var.app_service_plan_id
}
resource azurerm_app_service_custom_hostname_binding "custom_name" {
  hostname            = "${azurerm_app_service.app_service.name}.${var.domain_name}"
  app_service_name    = azurerm_app_service.app_service.name
  resource_group_name = var.resource_group_name
}
resource "null_resource" "configuration" {
  triggers = {
    app_service_id = azurerm_app_service.app_service.id
    custom_binding_id = azurerm_app_service_custom_hostname_binding.custom_name.id
  }
  provisioner "local-exec" {
    command = "az login --service-principal --username api://$ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID --verbose"
  }
  provisioner "local-exec" {
    command = "az network application-gateway address-pool create -g ${var.gateway_resource_group_name} --gateway-name ${var.gateway_name} -n ${azurerm_app_service.app_service.name}-pool --servers ${azurerm_app_service.app_service.default_site_hostname} --verbose"
  }
  provisioner "local-exec" {
    command = "az network application-gateway http-listener create --frontend-port ${var.frontend_port} --gateway-name ${var.gateway_name} --name ${azurerm_app_service.app_service.name}-listener --resource-group ${var.gateway_resource_group_name} --host-name ${azurerm_app_service_custom_hostname_binding.custom_name.hostname} --verbose"
  }
  provisioner "local-exec" {
    command = "az network application-gateway rule create --gateway-name ${var.gateway_name} --name ${azurerm_app_service.app_service.name}-rule --resource-group ${var.gateway_resource_group_name} --address-pool ${azurerm_app_service.app_service.name}-pool --http-listener ${azurerm_app_service.app_service.name}-listener --http-settings ${var.http_setting } "
  }

}
resource "null_resource" "configuration_delete" {
  # triggers = {
  #   configuration = null_resource.configuration.id
  # }
  provisioner "local-exec" {
    when = destroy
    command = "az login --service-principal --username api://$ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID --verbose"
  }
  provisioner "local-exec" {
    when = destroy
    command = "az network application-gateway rule delete -g ${var.gateway_resource_group_name} --gateway-name ${var.gateway_name} -n ${azurerm_app_service.app_service.name}-rule --verbose"
  }
  provisioner "local-exec" {
    when = destroy
    command = "az network application-gateway http-listener delete -g ${var.gateway_resource_group_name} --gateway-name ${var.gateway_name} -n ${azurerm_app_service.app_service.name}-listener --verbose"
  }
  provisioner "local-exec" {
    when = destroy
    command = "az network application-gateway address-pool delete -g ${var.gateway_resource_group_name} --gateway-name ${var.gateway_name} -n ${azurerm_app_service.app_service.name}-pool --verbose"
  }
}

