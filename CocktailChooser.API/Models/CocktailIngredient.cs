using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class CocktailIngredient
{
    public int? CocktailId { get; set; }

    public int? IngredientId { get; set; }

    public int? AmountId { get; set; }

    public virtual Amount? Amount { get; set; }

    public virtual Cocktail? Cocktail { get; set; }

    public virtual Ingredient? Ingredient { get; set; }
}
