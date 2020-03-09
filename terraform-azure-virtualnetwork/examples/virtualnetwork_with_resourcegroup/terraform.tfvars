# Uncomment the lines which require anything else from Defaults.
# (Optiona Default) Provide the Product Name for which the ResourceGroup is being created
# product =

# (Required) Provide the component for this Resource Group is being created
component = "virtualnetwork"

#  (Required) Provide the Environment in which this Resource Group is being created
environment = "lower"

# (Required) Provide the address space for the Virtual Network
address_space = "10.0.0.0/16"
# (Required) Pass the tags for Resource Group as a map
rg_tags = {
  Product     = "test"
  Environment = "lower"
  CreatedBy   = "Konasani,Divya"
  Component   = "virtualnetwork"
}
vnet_tags = {
  Product     = "test"
  Environment = "lower"
  CreatedBy   = "Konasani,Divya"
}
