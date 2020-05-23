# Introduction

[Source](https://docs.microsoft.com/en-us/azure/azure-app-configuration/quickstart-aspnet-core-app?tabs=core3x)

This is an ASPNETCore sample of using Azure App Configuration.

The terraform script will create 
- resource group
- app configuration

The script will output 
- a command to add the app configuration connection string to the local user secrets
- a sample AZ CLI command that must be run to add a sample key-value entries into the newly created app configuration.

The `add_connectionstring_to_usersecret_manager` output by the terraform command should be run in the aspnetcore code folder.  
It will add the app configuration connection string to the local user secrets and appear similar to:

```
dotnet user-secrets set ConnectionStrings:AppConfig <connectionstring>
```

Now the application will able to use this local variable to connect to the app configuration and pull the variables.

The app configuration key-value labels are used to illustrate the ability to load the same key with different values based on the label.

