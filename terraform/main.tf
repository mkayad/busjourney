resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_service_name}-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "S1" # Basic tier, change as needed
}

# App Service
resource "azurerm_linux_web_app" "main" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      java_server         = "JAVA"      # Changed from TOMCAT
      java_server_version = "21"        # Changed
      java_version        = "21"
    }

    always_on = false
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "false"
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    http_logs {
      file_system {
        retention_in_days = 2
        retention_in_mb   = 35
      }
    }
  }

  tags = {
    Environment = var.environment
  }
}

## Optional: Azure SQL Database
#resource "azurerm_mssql_server" "main" {
#  name                         = "${var.app_service_name}-sqlserver"
#  resource_group_name          = azurerm_resource_group.main.name
#  location                     = azurerm_resource_group.main.location
#  version                      = "12.0"
#  administrator_login          = "sqladmin"
#  administrator_login_password = "YourP@ssw0rd123!" # Use Azure Key Vault in production
#
#  tags = {
#    Environment = var.environment
#  }
#}
#
#resource "azurerm_mssql_database" "main" {
#  name      = "${var.app_service_name}-db"
#  server_id = azurerm_mssql_server.main.id
#  sku_name  = "S0"
#
#  tags = {
#    Environment = var.environment
#  }
#}