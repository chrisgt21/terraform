variable "name" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
    default = "eastus"
}

variable "allocation_method" {
    type = string
}

variable "sku" {
    type = string
}