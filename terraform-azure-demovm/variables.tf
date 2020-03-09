variable "vnet_name" {
  description = "Provide the name of the Virtual Network"
}

variable "resource_group_name" {
  description = "Specify the name of the Resource group where the Virtual Network to be created"
} 

variable "address_space" {
  description = "Pass the address space provided in the module. You can supply more than one address space. Changing this forces a new resource to be created."
}

variable "location" {
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
  type        = map(string)
  description = "(Required) Provide the tags to be passed to the Resource Group"
}

