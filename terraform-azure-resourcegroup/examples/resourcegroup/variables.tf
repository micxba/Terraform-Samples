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
variable "location" {
  description = "(Optional Default) Pass the location where RG to be created from the module"
  default     = "centralus"
}
variable "tags" {
  description = "(Required) Pass the tags for Resource Group as a map"
}

