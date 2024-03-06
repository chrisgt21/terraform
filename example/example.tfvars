resource_group_name = "test"

vnet_name = "test"

vnet_address_space = ["10.0.0.0/16"]

main_rt_name = "main"

database_rt_name = "database"

subnets = {
    "database-servers" = {
        cidr = ["10.0.3.0/24"]
        isPublic = false
        zone = 2
    }
    "web-servers" = {
        cidr = ["10.0.2.0/24"]
        isPublic = false
        zone = 2
    }
    "management-servers" = {
        cidr = ["10.0.1.0/24"]
        isPublic = false
        zone = 1
    }
}

# Subnet to route table map. Format is {"subnet-name": "rt-name"}
subnet_route_table_map = {
    #"database-servers" = "database"
}

routes = {
    "internet-route" = {
        address_prefix = "0.0.0.0/0"
        next_hop_type = "Internet"
    }
    "internal-route" = {
        address_prefix = "10.0.0.0/16"
        next_hop_type = "VnetLocal"
    }

}