using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using System.IO;
using Microsoft.Extensions.FileProviders;

public class EnvironmentFixture
{
    public IConfiguration Configuration { get; private set; }
    public IHostEnvironment Environment { get; private set; }

    public EnvironmentFixture()
    {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables();

        Configuration = builder.Build();

        Environment = new HostingEnvironment
        {
            EnvironmentName = "Test",
            ApplicationName = "CocktailChooser.Tests",
            ContentRootPath = Directory.GetCurrentDirectory()
        };
    }
}

public class HostingEnvironment : IHostEnvironment
{
    public string EnvironmentName { get; set; }
    public string ApplicationName { get; set; }
    public string ContentRootPath { get; set; }
    public string WebRootPath { get; set; }
    public IFileProvider WebRootFileProvider { get; set; }
    public IFileProvider ContentRootFileProvider { get; set; }
}