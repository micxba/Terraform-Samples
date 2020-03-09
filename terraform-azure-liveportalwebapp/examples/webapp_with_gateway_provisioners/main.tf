module "test_portal" {
  source              = "../../"
  app_service_name    = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = "centralus"
  app_service_plan_id = var.app_service_plan_id
  domain_name    = var.domain_name
  gateway_name        = var.gateway_name
  gateway_resource_group_name = var.gateway_resource_group_name
  frontend_port       = var.frontend_port
  http_setting        = var.http_setting
}