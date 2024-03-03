terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.0.0"
        }
    }
}

module "resource_group" {
    source = "github.com/chrisgt21/terraform/modules/azure/account_management/resource_group"
    name = var.resource_group_name
    
    
}

module "vnet" {
    source = "github.com/chrisgt21/terraform/modules/azure/network/vnet"

    name = var.vnet_name
    resource_group_name = var.resource_group_name
    address_space = var.vnet_address_space
    dns_servers = var.vnet_dns_servers

}