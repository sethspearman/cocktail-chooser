using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class Ingredient
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? IngredientTypeId { get; set; }

    public int? MixerSubtypeId { get; set; }

    public string? LongDescription { get; set; }

    public virtual IngredientType? IngredientType { get; set; }

    public virtual MixerSubtype? MixerSubtype { get; set; }
}
