resource "azurerm_subnet_nat_gateway_association" "ngw_association" {
    subnet_id                   = var.subnet_id
    nat_gateway_id              = var.nat_gateway_id
}