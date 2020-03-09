variable "resource_group_name" {
  description = "Pass the resource group name where the subnet, public ip and app gateway are to be created"
}
variable "virtual_network_name" {
  description = "Specify the Virtual network where the subnet and application gateway are to be created"
}
variable "gateway_subnet_address_prefix" {
  description = "provide the address preffix for ase subnet"
}
variable "public_ip_name" {
  description = "provide the name for public ip"
}
variable "location" {
  description = "provide the location where the public ip and application gateway are to be created"
}
variable "application_gateway_name" {
  description = "Specify the name of the Application gateway"
}
variable "backend_address_pool_name" {
  description = "Specify the backend address pool name"
}
variable "backend_http_setting_name" {
  description = "Provide the backend http setting name"
}
variable "probe_name" {
  description = "provide the probe name"
}
variable "frontend_ip_configuration_name" {
  description = "Specify the Frontend Ip Configuration name"
}
variable "frontend_port_name" {
  description = "Specify the Frontend port name"
}
variable "gateway_ip_configuration_name" {
  description = "Provide the gateway ip configuration name"
}
variable "http_listener_name" {
  description = "Provide the http listener name"
}
variable "request_routing_rule_name" {
  description = "specify the request routing rule name"
}

