variable "resource_group_name" {
    type = string
}

variable "vnet_name" {
    type = string
}

variable "vnet_address_space" {
    type = list(string)
}

variable "vnet_dns_servers" {
    type = list(string)
    default = []
}

# variable "database_server_subnet_prefix" {
#     type = list(string)
# }

# variable "subnets" {
#     type = map(list(string))
# }

variable "subnets" {
  type = map(object({
    cidr     = list(string)
    isPublic = bool
    zone = string
  }))
}


variable "subnet_route_table_map" {
    description = "A map of subnets to route tables"
    type = map(string)
}

variable "database_rt_name" {
    type = string
}

variable "main_rt_name" {
    type = string
}

variable "routes" {
    description = "A map of the CIDR ranges and their associated routes."
    type = map(object({
        address_prefix = string
        next_hop_type  = string
    }))
}