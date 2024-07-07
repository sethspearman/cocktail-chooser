using Xunit;

[assembly: CollectionBehavior(DisableTestParallelization = true)]

public class TestStartup
{
    public TestStartup()
    {
        // Set environment to 'Test'
        Environment.SetEnvironmentVariable("ASPNETCORE_ENVIRONMENT", "Test");
    }
}