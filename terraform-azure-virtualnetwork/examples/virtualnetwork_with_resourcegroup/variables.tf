variable "product" {
  description = "(Required) Provide the Product Name for which the ResourceGroup is being created."
  default     = "test"
}
variable "component" {
  description = "(Required) Provide the component for this Resource Group is being created"
}
variable "environment" {
  description = "(Required) Pass the environment for ehich this Resource Group is being created"
}
variable "address_space" {
  description = "(Required) Provide the address space for the Virtual Network"
}
variable "rg_tags" {
  description = "(Required) Pass the tags for Resource Group as a map"
}
variable "vnet_tags" {
  description = "(Required) Pass the tags for Resource Group as a map"
}

