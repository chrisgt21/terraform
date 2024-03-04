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

variable "database_server_subnet_prefix" {
    type = list(string)
}