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
