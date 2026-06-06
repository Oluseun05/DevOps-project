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

variable "jenkins_vm_size" {
  description = "Azure VM size for Jenkins server"
  type        = string
  default     = "Standard_B2s"
}

variable "jenkins_admin_username" {
  description = "Admin username for Jenkins VM"
  type        = string
  default     = "jenkinsadmin"
}

variable "jenkins_admin_password" {
  description = "Admin password for Jenkins VM — must meet Azure complexity requirements"
  type        = string
  sensitive   = true
}

variable "app_service_sku" {
  description = "App Service Plan SKU (B1 = Basic, S1 = Standard)"
  type        = string
  default     = "B1"
}
