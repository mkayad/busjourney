# Production Environment Variables
resource_group_name = "busjourney-prod-rg"
location = "West US2"
app_service_name = "busjourney-prod"
environment = "prod"

# MySQL Configuration - Production (larger, more robust)
mysql_database_name = "busjourney_prod_db"
mysql_sku_name = "B_Standard_B1s"
mysql_storage_size_gb = 20

# Networking Configuration - Production
vnet_address_space = "10.3.0.0/16"
app_service_subnet_address_prefix = "10.3.1.0/24"
mysql_subnet_address_prefix = "10.3.2.0/24"
key_vault_subnet_address_prefix = "10.3.3.0/24"
