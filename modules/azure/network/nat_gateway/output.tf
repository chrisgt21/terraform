output "id" {
    description = "The ID of the NAT Gateway."
    value = azurerm_nat_gateway.nat_gateway.id
}

output "resource_guid" {
    description = "The resource GUID property of the Nat Gateway."
    value = azurerm_nat_gateway.nat_gateway.resource_guid
}