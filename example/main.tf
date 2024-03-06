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
    address_prefixes = each.value.cidr
    depends_on = [module.vnet]

}

module "main_route_table" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route_table"
    source = "../modules/azure/network/route_table"

    name = var.main_rt_name
    resource_group_name = var.resource_group_name
    depends_on = [module.subnet]
}

module "database_route_table" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route_table"
    source = "../modules/azure/network/route_table"

    name = var.database_rt_name
    resource_group_name = var.resource_group_name
    depends_on = [module.subnet]
}

module "route_table_association" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route_table_association"
    source = "../modules/azure/network/route_table_association"
    for_each = module.subnet

    subnet_id = each.value.id
    #route_table_id = lookup(var.subnet_route_table_map, each.key, module.main_route_table.id)
    route_table_id = lookup(local.route_table_ids, lookup(var.subnet_route_table_map, each.key, "main"), "")
    depends_on = [module.main_route_table, module.database_route_table]
}


module "main_rt_routes" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/route"
    source = "../modules/azure/network/route"
    for_each = var.routes
    depends_on = [module.main_route_table, module.database_route_table]

    name = each.key
    resource_group_name = var.resource_group_name
    route_table_name = var.main_rt_name
    address_prefix = each.value.address_prefix
    next_hop_type = each.value.next_hop_type
}

module "ngw_public_ip_1" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/public_ip"
    source = "../modules/azure/network/public_ip"

    name = "ngw_ip_1"
    resource_group_name = var.resource_group_name
    allocation_method = "Static"
    sku = "Standard"
} 

module "ngw" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/nat_gateway"
    source = "../modules/azure/network/nat_gateway"

    name = "main_ngw"
    resource_group_name = var.resource_group_name
    idle_timeout_in_minutes = 5
    sku_name = "Standard"
    zones = ["1"]

}

module "ngw_association" {
    #source = "github.com/chrisgt21/terraform/modules/azure/network/nat_gateway_subnet_association"
    source = "../modules/azure/network/nat_gateway_subnet_association"

    for_each = { for k, v in var.subnets : k => v if !v.isPublic }

    subnet_id      = module.subnet[each.key].id
    nat_gateway_id = module.ngw.id
}