using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class CocktailSource
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string SourceType { get; set; } = null!;

    public string? Url { get; set; }

    public virtual ICollection<Cocktail> Cocktails { get; set; } = new List<Cocktail>();
}
