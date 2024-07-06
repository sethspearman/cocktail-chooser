using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class CocktailRecipe
{
    public int CocktailId { get; set; }

    public int StepNumber { get; set; }

    public string? Instruction { get; set; }

    public virtual Cocktail Cocktail { get; set; } = null!;
}
