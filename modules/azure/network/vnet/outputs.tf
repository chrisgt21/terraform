output "vnet_id" {
    description = "The ID of the Azure VNET"
    value = azurerm_virtual_network.vnet.id
}

# output "vnet_address_space" {
#     description = "The address space of the virtual network."
#     value = azurerm_virtual_network.address_space
# }