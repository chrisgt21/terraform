resource "azurerm_virtual_network" "vnet" {
    name                    = var.name
    location                = var.location
    resource_group_name     = var.resource_group_name
    address_space           = var.address_space
    dynamic "dns_servers" {
        for_each = var.dns_servers != null ? [var.dns_servers] : []
        content {
            dns_servers = dns_servers.value
        }
    }   
    
}