using System;
using System.Collections.Generic;

namespace CocktailChooser.API.Models;

public partial class Amount
{
    public int Id { get; set; }

    public string MeasurementName { get; set; } = null!;

    public double Ounces { get; set; }
}
