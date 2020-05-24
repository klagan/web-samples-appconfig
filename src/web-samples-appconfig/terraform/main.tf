resource "azurerm_resource_group" "my_resourcegroup" {
  name     = local.prefix
  location = var.location
}

resource "azurerm_app_configuration" "my_appconfig" {
  name                = local.prefix
  resource_group_name = azurerm_resource_group.my_resourcegroup.name
  location            = azurerm_resource_group.my_resourcegroup.location
  sku                 = var.app_configuration_sku
  depends_on          = [azurerm_resource_group.my_resourcegroup]
}

resource "null_resource" "deployment" {
  provisioner "local-exec" {
    command = <<EOT
      az appconfig kv set --connection-string '${azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string}' --key TestApp:Settings:BackgroundColor --value White --yes;
      az appconfig kv set --connection-string '${azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string}' --key TestApp:Settings:FontSize --value 24 --label sample --yes;
      az appconfig kv set --connection-string '${azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string}' --key TestApp:Settings:FontColor --value Green --label Development --yes;
      az appconfig kv set --connection-string '${azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string}' --key TestApp:Settings:Message --value 'Data from Azure App Configuration' --label sample --yes;
    EOT
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [azurerm_app_configuration.my_appconfig]
}