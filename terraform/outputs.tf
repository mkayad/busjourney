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