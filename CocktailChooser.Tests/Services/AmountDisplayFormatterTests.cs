using CocktailChooser.API.Services;

namespace CocktailChooser.Tests.Services;

public class AmountDisplayFormatterTests
{
    [Theory]
    [InlineData("0.25 oz", "¼ oz")]
    [InlineData("0.5 oz", "½ oz")]
    [InlineData("0.75 oz", "¾ oz")]
    [InlineData("1.25 fl oz", "1¼ fl oz")]
    [InlineData("1.5 fl oz", "1½ fl oz")]
    [InlineData("2.75 oz", "2¾ oz")]
    [InlineData("2.0 oz", "2 oz")]
    [InlineData("to top", "to top")]
    [InlineData("1/2 oz", "½ oz")]
    public void Format_NormalizesAmountDisplay(string input, string expected)
    {
        var formatted = AmountDisplayFormatter.Format(input);

        Assert.Equal(expected, formatted);
    }

    [Fact]
    public void FormatForIngredient_PrefersAmountName_WhenBothProvided()
    {
        var formatted = AmountDisplayFormatter.FormatForIngredient(null, "0.75 oz", "1/2 oz");

        Assert.Equal("¾ oz", formatted);
    }

    [Fact]
    public void FormatForIngredient_PrefersOriginalText_WhenPresent()
    {
        var formatted = AmountDisplayFormatter.FormatForIngredient("1½ fl oz", "1.5 oz", null);

        Assert.Equal("1½ fl oz", formatted);
    }

    [Fact]
    public void Format_ReturnsNull_ForBlankInput()
    {
        var formatted = AmountDisplayFormatter.Format("   ");

        Assert.Null(formatted);
    }
}
