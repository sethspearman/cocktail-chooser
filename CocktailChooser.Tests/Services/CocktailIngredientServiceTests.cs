using CocktailChooser.API.Services;
using CocktailChooser.Data.Repositories;
using Moq;

namespace CocktailChooser.Tests.Services;

public class CocktailIngredientServiceTests
{
    [Fact]
    public async Task GetAllCocktailIngredientsAsync_SetsDisplayAmount()
    {
        var repository = new Mock<ICocktailIngredientRepository>();
        repository.Setup(r => r.GetAllAsync())
            .ReturnsAsync(new List<CocktailIngredientRecord>
            {
                new()
                {
                    Id = 1,
                    CocktailId = 10,
                    IngredientId = 7,
                    IngredientName = "Lime Juice",
                    AmountName = "0.5 oz",
                    AmountText = "1/2 oz"
                }
            });

        var service = new CocktailIngredientService(repository.Object);

        var rows = (await service.GetAllCocktailIngredientsAsync()).ToList();

        Assert.Single(rows);
        Assert.Equal("½ oz", rows[0].DisplayAmount);
    }
}
