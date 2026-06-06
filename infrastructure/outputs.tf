output "jenkins_public_ip" {
  description = "SSH and browser access to Jenkins VM"
  value       = azurerm_public_ip.jenkins.ip_address
}

output "jenkins_url" {
  description = "Open this in your browser to access Jenkins"
  value       = "http://${azurerm_public_ip.jenkins.ip_address}:8080"
}

output "webapp_name" {
  description = "Paste this into the Jenkins WEBAPP_NAME_PARAM when running the pipeline"
  value       = azurerm_linux_web_app.main.name
}

output "webapp_url" {
  description = "Your live .NET application URL"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "jenkins_sp_client_id" {
  description = "Service Principal Client ID — add to Jenkins credentials"
  value       = azuread_application.jenkins.client_id
}

output "jenkins_sp_client_secret" {
  description = "Service Principal Client Secret — add to Jenkins credentials"
  value       = azuread_service_principal_password.jenkins.value
  sensitive   = true
}

output "tenant_id" {
  description = "Azure Tenant ID — needed for Jenkins Azure credential"
  value       = data.azuread_client_config.current.tenant_id
}

output "subscription_id" {
  description = "Azure Subscription ID — needed for Jenkins Azure credential"
  value       = data.azurerm_subscription.current.subscription_id
}
