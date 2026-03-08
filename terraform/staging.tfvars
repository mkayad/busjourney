# Staging Environment Variables
resource_group_name = "busjourney-staging-rg"
location = "West US2"
app_service_name = "busjourney-staging"
environment = "staging"

# MySQL Configuration - Staging (medium)
mysql_database_name = "busjourney_staging_db"
mysql_sku_name = "B_Standard_B1s"
mysql_storage_size_gb = 20

# Networking Configuration - Staging
vnet_address_space = "10.2.0.0/16"
app_service_subnet_address_prefix = "10.2.1.0/24"
mysql_subnet_address_prefix = "10.2.2.0/24"
key_vault_subnet_address_prefix = "10.2.3.0/24"
