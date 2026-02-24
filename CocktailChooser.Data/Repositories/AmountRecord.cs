namespace CocktailChooser.Data.Repositories;

public class AmountRecord
{
    public int Id { get; set; }
    public string MeasurementName { get; set; } = string.Empty;
    public double? Ounces { get; set; }
}
