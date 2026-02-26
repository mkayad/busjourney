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
    app_command_line = "java -jar /home/site/wwwroot/busjourney.jar"

    always_on = false
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "false"
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
    "SPRING_DATASOURCE_URL"          = "jdbc:mysql://${azurerm_mysql_flexible_server.main.fqdn}:3306/${azurerm_mysql_flexible_database.main.name}?useSSL=true&requireSSL=true&serverTimezone=UTC"
    "SPRING_DATASOURCE_USERNAME"     = azurerm_mysql_flexible_server.main.administrator_login
    "SPRING_DATASOURCE_PASSWORD"     = random_password.mysql_password.result
    "SPRING_JPA_HIBERNATE_DDL_AUTO"   = "update"
    "SPRING_JPA_SHOW_SQL"            = "true"
  }

  identity {
    type = "SystemAssigned"
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

## MySQL Server for Azure Database for MySQL
resource "azurerm_mysql_flexible_server" "main" {
  name                = "${var.app_service_name}-mysql-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  
  version           = "8.0"
  administrator_login = "mysqladmin"
  administrator_login_password = random_password.mysql_password.result
  
  storage {
    storage_size_gb = 20
  }
  
  sku_name = "B_Standard_B1s" # Burstable tier, change as needed
  
  backup {
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
  }
  
  high_availability {
    mode = "Disabled"
  }
  
  tags = {
    Environment = var.environment
  }
}

## MySQL Database
resource "azurerm_mysql_flexible_database" "main" {
  name                = var.mysql_database_name
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.main.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
  
  tags = {
    Environment = var.environment
  }
}

## Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                = "${var.app_service_name}-kv"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    
    key_permissions = [
      "Get", "List", "Create", "Delete", "Update"
    ]
    
    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover"
    ]
  }
  
  tags = {
    Environment = var.environment
  }
}

## Key Vault Secrets
resource "azurerm_key_vault_secret" "mysql_username" {
  name         = "mysql-username"
  value        = azurerm_mysql_flexible_server.main.administrator_login
  key_vault_id = azurerm_key_vault.main.id
  
  tags = {
    Environment = var.environment
  }
}

resource "azurerm_key_vault_secret" "mysql_password" {
  name         = "mysql-password"
  value        = random_password.mysql_password.result
  key_vault_id = azurerm_key_vault.main.id
  
  tags = {
    Environment = var.environment
  }
}

resource "azurerm_key_vault_secret" "mysql_connection_string" {
  name         = "mysql-connection-string"
  value        = "jdbc:mysql://${azurerm_mysql_flexible_server.main.fqdn}:3306/${azurerm_mysql_flexible_database.main.name}?useSSL=true&requireSSL=true&serverTimezone=UTC"
  key_vault_id = azurerm_key_vault.main.id
  
  tags = {
    Environment = var.environment
  }
}

## Random Password Generator
resource "random_password" "mysql_password" {
  length  = 16
  special = true
}

## Data source for current client configuration
data "azurerm_client_config" "current" {}