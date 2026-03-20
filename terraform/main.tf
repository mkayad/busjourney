resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

## Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.app_service_name}-vnet"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
  }
}

## Subnets
resource "azurerm_subnet" "app_service" {
  name                 = "app-service-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.app_service_subnet_address_prefix]

  delegation {
    name = "app-service-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "mysql" {
  name                 = "mysql-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.mysql_subnet_address_prefix]

  service_endpoints = ["Microsoft.Sql"]
  delegation {
    name = "mysql-delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_subnet" "key_vault" {
  name                 = "key-vault-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.key_vault_subnet_address_prefix]

  service_endpoints = ["Microsoft.KeyVault"]
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
      java_server_version = "25"        # Changed
      java_version        = "25"
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
  
  version           = "8.4"
  administrator_login = "mysqladmin"
  administrator_password = random_password.mysql_password.result

  storage {
    size_gb = var.mysql_storage_size_gb
  }
  
  sku_name = var.mysql_sku_name

  
  delegated_subnet_id = azurerm_subnet.mysql.id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql_dns.id
  
  tags = {
    Environment = var.environment
  }
}
# 1. Create the Private DNS Zone (If not already created by the MySQL resource)
resource "azurerm_private_dns_zone" "mysql_dns" {
  name                = "${var.environment}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name
}
# 2. LINK the DNS Zone to your VNet
resource "azurerm_private_dns_zone_virtual_network_link" "mysql_dns_link" {
  name                  = "mysql-dns-vnet-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql_dns.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = true
}


## MySQL Server Admin Password
resource "azurerm_mysql_flexible_server_firewall_rule" "allow_azure" {
  name                = "allow-azure-access"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_flexible_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

## Key Vault Secret for MySQL Password
resource "azurerm_key_vault_secret" "mysql_password" {
  name         = "mysql-password"
  value        = random_password.mysql_password.result
  key_vault_id = azurerm_key_vault.main.id
  
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
}

## Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                = "${var.app_service_name}-kv"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  
  network_acls {
    default_action             = "Allow"
    bypass                    = "AzureServices"
    virtual_network_subnet_ids = [azurerm_subnet.key_vault.id]
  }
  
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

resource "azurerm_key_vault_secret" "mysql_connection_string" {
  name         = "mysql-connection-string"
  value        = "jdbc:mysql://${azurerm_mysql_flexible_server.main.name}.${azurerm_private_dns_zone.mysql_dns.name}:3306/${azurerm_mysql_flexible_database.main.name}?useSSL=true&requireSSL=true&serverTimezone=UTC"
  key_vault_id = azurerm_key_vault.main.id
  
  tags = {
    Environment = var.environment
  }
}

## Random Password Generator
resource "random_password" "mysql_password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

## Data source for current client configuration
data "azurerm_client_config" "current" {}