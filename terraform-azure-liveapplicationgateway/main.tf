terraform {
  required_version = "0.12.17"
  backend "azurerm" {}
}
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "Gateway-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefix       = var.gateway_subnet_address_prefix
}
resource "azurerm_public_ip" "gateway_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_application_gateway" "application_gateway" {
  name                = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  backend_address_pool {
    name = var.backend_address_pool_name
    # ip_addresses = var.backend_ip_addresses
    # ["10.0.2.11"]
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = var.backend_http_setting_name
    port                  = "80"
    # Health probes are not a required argument. Even without the attribute was able to create application gateway
    probe_name                          = var.probe_name
    protocol                            = "Http"
    request_timeout                     = "300"
    pick_host_name_from_backend_address = "true"
  }
  frontend_ip_configuration {
    name = var.frontend_ip_configuration_name
    # subnet_id = azurerm_subnet.gateway_subnet.id Cannot have both subnet id and public ip
    public_ip_address_id = azurerm_public_ip.gateway_public_ip.id
  }
  frontend_port {
    name = var.frontend_port_name
    port = "80"
  }
  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = azurerm_subnet.gateway_subnet.id
  }
  http_listener {
    name                           = var.http_listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
    host_name                      = "default"
  }
  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.http_listener_name
    backend_http_settings_name = var.backend_http_setting_name
    backend_address_pool_name  = var.backend_address_pool_name
  }
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = "1"
  }
  probe {
    interval                                  = "5"
    name                                      = var.probe_name
    protocol                                  = "Http"
    path                                      = "/"
    timeout                                   = "300"
    unhealthy_threshold                       = "3"
    pick_host_name_from_backend_http_settings = "true"
  }
}