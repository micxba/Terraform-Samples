# This resource is provisioned to generate random id and attach to the name of Resource Group to ensure uniqueness of name
resource "random_id" "randomid" {
  byte_length = 2
}

module "test_ase_resourcegroup" {
  source   = "../../"
  name     = "${var.product}_${var.component}_${var.environment}_${random_id.randomid.hex}"
  location = "${var.location}"
  tags     = "${var.tags}"
}



