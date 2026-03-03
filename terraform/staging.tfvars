# Staging Environment Variables
resource_group_name = "busjourney-staging-rg"
location = "West US2"
app_service_name = "busjourney-staging"
environment = "staging"

# MySQL Configuration - Staging (medium)
mysql_database_name = "busjourney_staging_db"
mysql_sku_name = "B_Standard_B1s"
mysql_storage_size_gb = 20
