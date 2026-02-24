namespace CocktailChooser.Data.Repositories;

public interface IAmountRepository
{
    Task<IEnumerable<AmountRecord>> GetAllAsync();
}
