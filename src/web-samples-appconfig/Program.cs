using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration.AzureAppConfiguration;

namespace web_samples_appconfig
{
    public class Program
    {
        public static void Main(
            string[] args
        )
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(
            string[] args
        ) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.ConfigureAppConfiguration((
                            hostingContext,
                            config
                        ) =>
                        {
                            var settings = config.Build();

                            config.AddAzureAppConfiguration(options =>
                                options
                                    .Connect(settings["ConnectionStrings:AppConfig"])
                                    .Select(KeyFilter.Any, LabelFilter.Null) // load the un-labelled keys
                                    .Select(KeyFilter.Any, "sample") // override with the keys labelled 'sample'
                                    .Select(KeyFilter.Any, hostingContext.HostingEnvironment.EnvironmentName)); // override with keys labelled as the current environment
                        })
                        .UseStartup<Startup>();
                });
    }
}