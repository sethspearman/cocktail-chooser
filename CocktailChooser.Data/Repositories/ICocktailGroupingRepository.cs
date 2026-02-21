namespace CocktailChooser.Data.Repositories;

public interface ICocktailGroupingRepository
{
    Task<IEnumerable<CocktailGroupingLinkRecord>> GetByGroupingNameAsync(string groupingName);
    Task<IEnumerable<CocktailGroupingCocktailRecord>> GetCocktailsByGroupingNameAsync(string groupingName);
    Task<CocktailGroupingLinkRecord> UpsertAsync(CocktailGroupingLinkRecord link);
    Task<bool> RenameAsync(int cocktailId, int cocktailSourceId, string groupingName, string newGroupingName);
}
