# This resource is provisioned to generate random id and attach to the name of Resource Group to ensure uniqueness of name
resource "random_id" "randomid" {
  byte_length = 2
}
module "test_virtualnetwork" {
  source                         = "../../"
  rg_name                        = "${var.product}_${var.component}_${var.environment}_rg_${random_id.randomid.hex}"
  rg_location                    = "centralus"
  rg_tags                        = "${var.rg_tags}"
  vnet_name                      = "${var.product}_${var.environment}_vnet_${random_id.randomid.hex}"
  address_space                  = "${var.address_space}"
  vnet_location                  = "centralus"
  vnet_tags                      = "${var.vnet_tags}"
}

