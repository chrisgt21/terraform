output "id" {
    description = "The ID of the security group rule"
    value = azurerm_network_security_rule.sg_rule.id
}