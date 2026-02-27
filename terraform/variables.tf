variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "terraform-state-rg-test"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West US2"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default = "busjourney-app-plan"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "mysql_database_name" {
  description = "Name of the MySQL database"
  type        = string
  default     = "busjourney_db"
}

variable "mysql_sku_name" {
  description = "SKU name for MySQL server"
  type        = string
  default     = "B_Standard_B1s"
}

variable "mysql_storage_size_gb" {
  description = "Storage size for MySQL server in GB"
  type        = number
  default     = 20
}