using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CocktailIngredientsController : ControllerBase
{
    private readonly ICocktailIngredientService _service;

    public CocktailIngredientsController(ICocktailIngredientService service)
    {
        _service = service;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CocktailIngredientDto>>> GetCocktailIngredients()
    {
        var rows = await _service.GetAllCocktailIngredientsAsync();
        return Ok(rows);
    }

    [HttpGet("by-cocktail/{cocktailId:int}")]
    public async Task<ActionResult<IEnumerable<CocktailIngredientDto>>> GetCocktailIngredientsByCocktailId(int cocktailId)
    {
        var rows = await _service.GetCocktailIngredientsByCocktailIdAsync(cocktailId);
        return Ok(rows);
    }
}
