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
  default = "Busjourney-app-plan"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}