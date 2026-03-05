using CocktailChooser.Data.Repositories;

namespace CocktailChooser.Tests.Services;

public class AmountCanonicalizerTests
{
    [Theory]
    [InlineData("1.5 oz", 1.5, "oz")]
    [InlineData("1 1/2 oz", 1.5, "oz")]
    [InlineData("1½ oz", 1.5, "oz")]
    [InlineData("0.75 fl oz", 0.75, "oz")]
    [InlineData("2 dashes", 2, "dash")]
    [InlineData("1 tbsp", 1, "tbsp")]
    [InlineData("3", 3, "count")]
    public void Parse_ParsesKnownNumericPatterns(string input, double expectedValue, string expectedUnit)
    {
        var result = AmountCanonicalizer.Parse(input);

        Assert.Equal(expectedValue, result.Value);
        Assert.Equal(expectedUnit, result.Unit);
    }

    [Theory]
    [InlineData("to top", "top")]
    [InlineData("to rinse", "rinse")]
    [InlineData("for rinse", "rinse")]
    public void Parse_ParsesInstructionalUnits(string input, string expectedUnit)
    {
        var result = AmountCanonicalizer.Parse(input);

        Assert.Null(result.Value);
        Assert.Equal(expectedUnit, result.Unit);
    }

    [Fact]
    public void FromAmountReference_FallsBackToOunces()
    {
        var result = AmountCanonicalizer.FromAmountReference("something odd", 2.25);

        Assert.Equal(2.25, result.Value);
        Assert.Equal("oz", result.Unit);
    }
}
