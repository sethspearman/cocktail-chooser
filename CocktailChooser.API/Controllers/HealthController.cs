using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[ApiController]
[Route("health")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public ActionResult<object> Get()
    {
        return Ok(new
        {
            status = "ok",
            utc = DateTime.UtcNow
        });
    }
}
