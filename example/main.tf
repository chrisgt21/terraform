terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.0.0"
        }
    }
}


provider "azurerm" {
    features {}
}

locals {
    route_table_ids = {
        "main" = module.main_route_table.id
        "database" = module.database_route_table.id
    }
}


module "resource_group" {
    #source = "github.com/chrisgt21/terraform/modules/azure/account_management/resource_group"
    source = "../modules/azure/account_management/resource_group"
    name = var.resource_group_name
}

module "vnet" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/vnet"
    source = "../modules/azure/network/vnet"

    name = var.vnet_name
    resource_group_name = var.resource_group_name
    address_space = var.vnet_address_space
    dns_servers = var.vnet_dns_servers
    depends_on = [module.resource_group]
}

module "subnet" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/subnet"
    source = "../modules/azure/network/subnet"
    for_each = var.subnets

    resource_group_name = var.resource_group_name
    name = each.key
    virtual_network_name = var.vnet_name
    address_prefixes = each.value
    depends_on = [module.vnet]

}

module "main_route_table" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route_table"
    source = "../modules/azure/network/route_table"

    name = "main"
    resource_group_name = var.resource_group_name
    depends_on = [module.subnet]
}

module "database_route_table" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route_table"
    source = "../modules/azure/network/route_table"

    name = "database"
    resource_group_name = var.resource_group_name
    depends_on = [module.subnet]
}

module "route_table_association" {
    source = "../modules/azure/network/route_table_association"
    for_each = module.subnet

    subnet_id = each.value.id
    #route_table_id = lookup(var.subnet_route_table_map, each.key, module.main_route_table.id)
    route_table_id = lookup(local.route_table_ids, lookup(var.subnet_route_table_map, each.key, "main"), "")
    depends_on = [module.main_route_table, module.database_route_table]
}