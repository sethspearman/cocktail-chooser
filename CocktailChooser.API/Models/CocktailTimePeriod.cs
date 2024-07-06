using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class CocktailTimePeriod
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public string? LongDescription { get; set; }

    public virtual ICollection<Cocktail> Cocktails { get; set; } = new List<Cocktail>();
}
