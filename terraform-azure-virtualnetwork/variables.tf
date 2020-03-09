variable "rg_name" {
  description = "(Required) Provide the name of the Resource Group to be created"
}
variable "rg_location" {
  description = "(Required) Pass the location where RG to be created from the module"
}
variable "rg_tags" {
  type        = "map"
  description = "(Required) Provide the tags to be passed to the Resource Group"
}
variable "vnet_name"{
  description = "Provide the name of the Virtual Network"
}
# resourcegroup_name is passed from the resource  
variable "address_space" {
  description = "Pass the address space provided in the module. You can supply more than one address space. Changing this forces a new resource to be created."
}
variable "vnet_location" {
  description = "Pass the Resource Group Location from the RG module in the main.tf"
}

# Uncomment the following 2 variable definitions if DDOS Protection needs to enabled for the Virtual Network
# variable "vnet_ddosprotectionplan_id" {
#     description = "The Resource ID of DDoS Protection Plan. It is a required value"
# }
# variable "vnet_ddosprotectionplan_enable" {
#     description = "Pass the value to Enable/disable DDoS Protection Plan on Virtual Network. Possible values are True, False"
# }
variable "vnet_tags" {
  type        = "map"
  description = "(Required) Provide the tags to be passed to the Resource Group"
}