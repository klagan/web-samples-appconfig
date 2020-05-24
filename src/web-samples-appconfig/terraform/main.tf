resource "azurerm_resource_group" "my_resourcegroup" {
  name     = local.prefix
  location = var.location
}

resource "azurerm_app_configuration" "my_appconfig" {
  name                = local.prefix
  resource_group_name = azurerm_resource_group.my_resourcegroup.name
  location            = azurerm_resource_group.my_resourcegroup.location
  sku                 = var.app_configuration_sku
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

  # trigger is saying: if this property changes then run the provisioner
  # triggers = {
  #  # always_run = "${timestamp()}"
  #  if_app_one_application_id_changes = azuread_application.my_api_one_appreg.application_id
  #  if_app_two_application_id_changes = azuread_application.my_api_two_appreg.application_id
  #}

  # depends_on = [azuread_application.my_api_one_appreg, azuread_application.my_api_two_appreg]
}