module "virtualnetwork" {
    source = "../../../"
    resource_group_name = "test_rg"
    vnet_name = "test_vnet"
    address_space = "10.0.0.0/16"
    location = "centralus"
    vnet_tags = {
        test = "plan"
    }
}
