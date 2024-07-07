using Xunit;

public class EnvironmentFixture
{
    public EnvironmentFixture()
    {
        new TestStartup();
    }
}

[CollectionDefinition("Environment collection")]
public class EnvironmentCollection : ICollectionFixture<EnvironmentFixture>
{
}