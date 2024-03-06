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

variable "idle_timeout_in_minutes" {
    type = string
}

variable "sku_name" {
    type = string
}

variable "zones" {
    type = list(string)
}