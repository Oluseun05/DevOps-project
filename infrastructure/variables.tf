variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "app_name" {
  description = "Application name prefix for all resources"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment tag applied to all resources"
  type        = string
  default     = "prod"
}

variable "tenant_id" {
  description = "Azure Tenant ID (from az login output)"
  type        = string
}

variable "app_service_sku" {
  description = "App Service Plan SKU (B1 = Basic, S1 = Standard)"
  type        = string
  default     = "B1"
}
