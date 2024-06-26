variable "name" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

variable "resource_group_name" {
    type = string
}

variable "disable_bgp_route_propagation" {
    type = bool
    default = true
}