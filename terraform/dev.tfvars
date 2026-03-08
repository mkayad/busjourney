# Development Environment Variables
resource_group_name = "busjourney-dev-rg"
location = "West US2"
app_service_name = "busjourney-dev"
environment = "dev"

# MySQL Configuration - Dev (smaller, cost-effective)
mysql_database_name = "busjourney_dev_db"
mysql_sku_name = "B_Standard_B1s"
mysql_storage_size_gb = 20

# Networking Configuration - Dev
vnet_address_space = "10.1.0.0/16"
app_service_subnet_address_prefix = "10.1.1.0/24"
mysql_subnet_address_prefix = "10.1.2.0/24"
key_vault_subnet_address_prefix = "10.1.3.0/24"
