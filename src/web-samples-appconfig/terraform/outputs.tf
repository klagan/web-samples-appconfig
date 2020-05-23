output sample_keyvalue_entry {
   value = [
      format("az appconfig kv set --connection-string '%s' --key TestApp:Settings:BackgroundColor --value White --yes", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string),
      format("az appconfig kv set --connection-string '%s' --key TestApp:Settings:FontSize --value 24 --label sample --yes", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string),
      format("az appconfig kv set --connection-string '%s' --key TestApp:Settings:FontColor --value Green --label Development --yes", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string),
      format("az appconfig kv set --connection-string '%s' --key TestApp:Settings:Message --value 'Data from Azure App Configuration' --label sample --yes", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string)
   ]
}

output add_connectionstring_to_usersecret_manager {
   value = format("dotnet user-secrets set ConnectionStrings:AppConfig '%s'", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string)
}