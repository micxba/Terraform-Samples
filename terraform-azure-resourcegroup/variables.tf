variable "name" {
  description = "(Required) Provide the name of the Resource Group to be created"
}
variable "location" {
  description = "(Required) Pass the location where RG to be created from the module"
}
variable "tags" {
  type        = "map"
  description = "(Required) Provide the tags to be passed to the Resource Group"
}
