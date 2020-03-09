module "test_ase_plan" {
  source                     = "../../"
  app_plan_name              = var.app_plan_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_environment_id = var.app_service_environment_id
}