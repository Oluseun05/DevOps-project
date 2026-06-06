data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

resource "azuread_application" "jenkins" {
  display_name = "${var.app_name}-jenkins-sp"
}

resource "azuread_service_principal" "jenkins" {
  client_id = azuread_application.jenkins.client_id
}

resource "azuread_service_principal_password" "jenkins" {
  service_principal_id = azuread_service_principal.jenkins.id
}

resource "azurerm_role_assignment" "jenkins_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.jenkins.object_id
}
