output "test_resourcegroup_name" {
  value = azurerm_resource_group.test_resourcegroup.name
}

output "test_virtualnetwork_vnet_name" {
  value = module.test_virtualnetwork.virtualnetwork_name
}

output "test_virtualnetwork_vnet_id" {
  value = module.test_virtualnetwork.virtualnetwork_id
}

output "test_virtualnetwork_vnet_location" {
  value = module.test_virtualnetwork.virtualnetwork_location
}

output "test_virtualnetwork_vnet_address_space" {
  value = module.test_virtualnetwork.virtualnetwork_address_space
}

output "test_virtualnetwork_resourcegroup_name" {
  value = module.test_virtualnetwork.virtualnetwork_resourcegroup_name
}

