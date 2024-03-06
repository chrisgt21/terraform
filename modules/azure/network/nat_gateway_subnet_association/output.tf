output "id" {
    description = "The ID of the subnet."
    value = azurerm_subnet_nat_gateway_association.ngw_association.id
}