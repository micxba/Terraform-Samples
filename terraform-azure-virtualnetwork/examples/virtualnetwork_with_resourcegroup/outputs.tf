output "test_virtualnetwork_rg_name" {
  value = "${module.test_virtualnetwork.resourcegroup_name}"
}
output "test_virtualnetwork_rg_location" {
  value = "${module.test_virtualnetwork.resourcegroup_location}"
}
output "test_virtualnetwork_rg_id" {
  value = "${module.test_virtualnetwork.resourcegroup_id}"
}
output "test_virtualnetwork_vnet_name" {
  value = "${module.test_virtualnetwork.virtualnetwork_name}"
}
output "test_virtualnetwork_vnet_id" {
  value = "${module.test_virtualnetwork.virtualnetwork_id}"
}
output "test_virtualnetwork_vnet_location" {
  value = "${module.test_virtualnetwork.virtualnetwork_location}"
}
output "test_virtualnetwork_vnet_address_space" {
  value = "${module.test_virtualnetwork.virtualnetwork_address_space}"
}

