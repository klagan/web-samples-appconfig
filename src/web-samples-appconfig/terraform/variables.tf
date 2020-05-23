locals {
  prefix           = format("%s-%s-%s", var.client, var.environment, random_string.random_five.result)
  # connectionstring = format("Endpoint=%s;Id=%s;Secret=%s", azurerm_app_configuration.my_appconfig.connectionstring, azurerm_app_configuration.my_appconfig.primary_write_key.id, azurerm_app_configuration.my_appconfig.primary_write_key.secret)
}

variable client {}

variable environment {}

variable location {}

variable app_configuration_sku {}

resource "random_string" "random_five" {
  length           = 5
  special          = false
  upper            = false
  # override_special = "/@£$"
}