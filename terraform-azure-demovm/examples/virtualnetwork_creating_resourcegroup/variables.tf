variable "component" {
  description = "(Required) Provide the Component for which the Resource Group is being created"
  default     = "virtualnetwork"
}

variable "rg_location" {
  description = "(Required) Provide the location for Resource Group"
  default     = "centralus"
}

variable "rg_tags" {
  description = "(Required) Specify the tags for resource group"
}

variable "product" {
  description = "(Required) Provide the Product Name for which the ResourceGroup is being created."
  default     = "test"
}

variable "environment" {
  description = "(Required) Pass the environment for ehich this Resource Group is being created"
  default     = "module"
}

variable "location" {
  description = "(Required) Provide the location in which the virtual network to be created"
  default     = "centralus"
}

variable "address_space" {
  description = "(Required) Provide the address space for the Virtual Network"
}

variable "vnet_tags" {
  description = "(Required) Pass the tags for virtual network as a map"
}

