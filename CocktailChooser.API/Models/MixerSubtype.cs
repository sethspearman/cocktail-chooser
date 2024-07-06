using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class MixerSubtype
{
    public int Id { get; set; }

    public int? MixerTypeId { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<Ingredient> Ingredients { get; set; } = new List<Ingredient>();

    public virtual MixerType? MixerType { get; set; }
}
