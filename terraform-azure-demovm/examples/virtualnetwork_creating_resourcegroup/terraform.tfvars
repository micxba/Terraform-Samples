# Uncomment the lines which require anything else from Defaults.
# (Optiona Default) Provide the Product Name for which the ResourceGroup is being created. Default is test
# product =

# (Optional Default) Provide the Component for which the Resource Group is being created. Default is Virtual Network
#  component =

#  (Required) Specify the tags for resource group 
rg_tags = {
  Product = "test"
  Environment = "lower"
  CreatedBy = "Konasani, Divya"
}
# (Optional Default) Provide the Environment in which this Resource Group is being created. Default is Module
# environment = 

# (Required) Provide the address space for the Virtual Network
address_space = "10.0.0.0/16"

# (Optional Default) Provide the virtual network location. Default is centralus
# vnet_location

# (Required) Pass the tags for virtual network as a map
vnet_tags = {
  Product     = "test"
  Environment = "lower"
  CreatedBy   = "Konasani,Divya"
}
