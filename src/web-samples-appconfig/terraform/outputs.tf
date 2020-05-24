output add_connectionstring_to_usersecret_manager {
  value       = format("dotnet user-secrets set ConnectionStrings:AppConfig '%s'", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string)
  description = "kam test"
}