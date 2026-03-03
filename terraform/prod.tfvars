# Production Environment Variables
resource_group_name = "busjourney-prod-rg"
location = "West US2"
app_service_name = "busjourney-prod"
environment = "prod"

# MySQL Configuration - Production (larger, more robust)
mysql_database_name = "busjourney_prod_db"
mysql_sku_name = "B_Standard_B1s"
mysql_storage_size_gb = 20
