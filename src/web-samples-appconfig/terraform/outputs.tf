output sample_keyvalue_entry {
   value = format("az appconfig kv set --connection-string '%s' --key color --label MyLabel --value red --yes", azurerm_app_configuration.my_appconfig.primary_write_key.0.connection_string)
}
