using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class IngredientType
{
    public int Id { get; set; }

    public string Type { get; set; } = null!;

    public virtual ICollection<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
}
