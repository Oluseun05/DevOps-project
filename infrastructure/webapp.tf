resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = var.app_service_sku

  tags = { environment = var.environment }
}

resource "azurerm_linux_web_app" "main" {
  name                = "${var.app_name}-webapp-${random_string.suffix.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  webdeploy_publish_basic_authentication_enabled = false
  ftp_publish_basic_authentication_enabled       = false

  site_config {
    always_on = false

    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "ASPNETCORE_ENVIRONMENT"   = "Production"
  }

  tags = {
    environment = var.environment
    app         = var.app_name
  }
}
