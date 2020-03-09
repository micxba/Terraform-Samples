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