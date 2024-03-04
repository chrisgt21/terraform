output "id" {
    description = "The ID of the route table"
    value = azurerm_route_table.route_table.id

}

output "subnets" {
    description = "The collection of subnets assocated with the route table."
    value = azurerm_route_table.route_table.subnets
}