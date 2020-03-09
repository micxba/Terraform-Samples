module "test_gateway" {
    source = "../../"
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    gateway_subnet_address_prefix = var.gateway_subnet_address_prefix
    location = var.location
    public_ip_name = var.public_ip_name
    application_gateway_name = var. application_gateway_name 
    backend_address_pool_name = "default_backend_address_pool"
    backend_http_setting_name = "default_backend_http_setting"
    probe_name = "default_probe_name"
    frontend_ip_configuration_name = "frontend_ip_configuration"
    frontend_port_name = "frontend_port"
    gateway_ip_configuration_name = "gateway_ip_configuration"
    http_listener_name = "default_http_listener"
    request_routing_rule_name = "default_rule"
}