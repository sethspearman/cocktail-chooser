using CocktailChooser.API.Controllers;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.Tests.Controllers;

public class HealthControllerTests
{
    [Fact]
    public void Get_ReturnsOk()
    {
        var controller = new HealthController();

        var result = controller.Get();

        var okResult = Assert.IsType<OkObjectResult>(result.Result);
        Assert.NotNull(okResult.Value);
    }

    [Fact]
    public void Get_ReturnsStatusOkPayload()
    {
        var controller = new HealthController();

        var result = controller.Get();

        var okResult = Assert.IsType<OkObjectResult>(result.Result);
        var status = okResult.Value?.GetType().GetProperty("status")?.GetValue(okResult.Value) as string;
        Assert.Equal("ok", status);
    }
}
