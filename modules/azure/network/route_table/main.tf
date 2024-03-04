resource "azurerm_resource_group" "route_table" {
    name                                = var.name
    location                            = var.location
    resource_group_name                 = var.resource_group_name
    disable_bgp_route_propagation       = var.disable_bgp_route_propagation
}