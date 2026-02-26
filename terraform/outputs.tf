output "app_service_default_hostname" {
  value       = azurerm_linux_web_app.main.default_hostname
  description = "The default hostname of the App Service"
}

output "app_service_id" {
  value = azurerm_linux_web_app.main.id
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "mysql_server_fqdn" {
  value       = azurerm_mysql_flexible_server.main.fqdn
  description = "The fully qualified domain name of the MySQL server"
}

output "mysql_server_id" {
  value       = azurerm_mysql_flexible_server.main.id
  description = "The ID of the MySQL server"
}

output "mysql_database_name" {
  value       = azurerm_mysql_flexible_database.main.name
  description = "The name of the MySQL database"
}

output "key_vault_id" {
  value       = azurerm_key_vault.main.id
  description = "The ID of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.main.vault_uri
  description = "The URI of the Key Vault"
}

output "key_vault_name" {
  value       = azurerm_key_vault.main.name
  description = "The name of the Key Vault"
}