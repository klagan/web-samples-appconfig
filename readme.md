# Introduction
This is an ASPNETCore sample of using Azure App Configuration. 

This sample assumes comfort using Terraform CLI to build the associated infrastructure.

In short:
- ensure Terraform is installed/available
- navigate to the `terraform` folder in a CLI
- run `terraform init`
- run `terraform plan`
- run `terraform apply`

This should be enough to build the associated infrastructure.  To tear down the associated infrastructure navigate to the `terraform` folder and run `terraform destroy`

The terraform script will:
- create resource group
- create app configuration
- add sample entries into the app configuration

The terraform script will output 
- a command to add the app configuration connection string to the local user secrets

The `add_connectionstring_to_usersecret_manager` output by the terraform command should be run in the aspnetcore code folder.  

It will add the app configuration connection string to the local user secrets and appear similar to:

```dotnetcli
dotnet user-secrets set ConnectionStrings:AppConfig <connectionstring>
```

Now the application will able to use this local variable to connect to the app configuration and pull the variables.

The app configuration key-value labels are used to illustrate the ability to load the same key with different values based on the label.

---
## Feature management

#### Tag helper

Add the following includes to the page:
```
@addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers
@addTagHelper *, Microsoft.FeatureManagement.AspNetCore
```

Then you can use the `feature` tag:

```$xslt
<feature name="BetaFeature">
    <h3>Beta feature enabled</h3>
</feature>
```

> (See the example in `views\home\index.cshtml`)

#### Controller/Action
Add this attribute to an action or controller to enable or disable it.  404 is returned if the feature is turned off and and attempt to access the action/controller made
```csharp
[FeatureGate("BetaFeature")]
```

#### Manual 
Inject this object to a class:

```csharp
private readonly IFeatureManager _featureManager;
 
public HomeController(IFeatureManager featureManager)
{
    _featureManager = featureManager;
}
```
Use the object to manage the feature:
```csharp
if (await _featureManager.IsEnabledAsync("BetaFeature"))
{
    <do something>
}
```

---
## Project details
[Source 1](https://docs.microsoft.com/en-us/azure/azure-app-configuration/quickstart-aspnet-core-app?tabs=core3x)
<br>
[Source 2](https://docs.microsoft.com/en-us/azure/azure-app-configuration/howto-labels-aspnet-core)

Project requires the following packages:
```dotnetcli
dotnet add package Microsoft.Azure.AppConfiguration.AspNetCore
dotnet add package Microsoft.FeatureManagement.AspNetCore 
```
and it is good practice to use user secrets locally:
``` xml
<PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
    <UserSecretsId>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</UserSecretsId>
</PropertyGroup>
```
You can add secrets to the locsal user secrets vault:
```dotnetcli
dotnet user-secrets set <key> <value>
```
---
