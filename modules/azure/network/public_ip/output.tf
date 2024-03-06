output "id" {
    description = "The ID of the public IP address."
    value = azurerm_public_ip.public_ip.id
}

output "ip_address" {
    description = "The public IP adress value that was allocated."
    value = azurerm_public_ip.public_ip.ip_address
}