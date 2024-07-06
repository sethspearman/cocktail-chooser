using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class Cocktail
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public string? Method { get; set; }

    public int? GlassTypeId { get; set; }

    public int? TimePeriodId { get; set; }

    public int? IsPopular { get; set; }

    public int? CocktailSourceId { get; set; }

    public virtual ICollection<CocktailRecipe> CocktailRecipes { get; set; } = new List<CocktailRecipe>();

    public virtual CocktailSource? CocktailSource { get; set; }

    public virtual GlassType? GlassType { get; set; }

    public virtual CocktailTimePeriod? TimePeriod { get; set; }
}
