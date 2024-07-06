using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class GlassType
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Cocktail> Cocktails { get; set; } = new List<Cocktail>();
}
