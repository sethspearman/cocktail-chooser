# Step-by-Step Process for API Changes

1. **Update Models and DTOs**:
    - Modify or add new properties to your models in the `Models` folder.
    - Update or create new DTOs in the `DTOs` folder to reflect changes in your models.

    ```csharp
    public class Cocktail
    {
        public int Id { get; set; }
        public string Name { get; set; }
        // Add new properties here
    }

    public class CocktailDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        // Add new properties here
    }
    ```

2. **Update AutoMapper Profile**:
    - Ensure that the AutoMapper profile is updated to map between your models and DTOs correctly.

    ```csharp
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Cocktail, CocktailDto>().ReverseMap();
            // Add mappings for new properties
        }
    }
    ```

3. **Modify Services**:
    - Update existing services or create new ones to handle the business logic for your new or modified API endpoints.

    ```csharp
    public class CocktailService : ICocktailService
    {
        private readonly CocktailChooserContext _context;
        private readonly IMapper _mapper;

        public CocktailService(CocktailChooserContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<IEnumerable<CocktailDto>> GetAllCocktailsAsync()
        {
            var cocktails = await _context.Cocktails.ToListAsync();
            return _mapper.Map<IEnumerable<CocktailDto>>(cocktails);
        }

        // Add new methods or update existing ones
    }
    ```

4. **Update Controllers**:
    - Modify or add new actions in your controllers to handle the API requests.

    ```csharp
    [ApiController]
    [Route("api/[controller]")]
    public class CocktailsController : ControllerBase
    {
        private readonly ICocktailService _service;

        public CocktailsController(ICocktailService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CocktailDto>>> GetCocktails()
        {
            var cocktails = await _service.GetAllCocktailsAsync();
            return Ok(cocktails);
        }

        // Add new actions or update existing ones
    }
    ```

5. **Update or Create Unit Tests**:
    - Write new unit tests or update existing ones to test the new or modified functionality.

    ```csharp
    public class CocktailsControllerTests
    {
        private readonly Mock<ICocktailService> _mockService;
        private readonly CocktailsController _controller;

        public CocktailsControllerTests()
        {
            _mockService = new Mock<ICocktailService>();
            _controller = new CocktailsController(_mockService.Object);
        }

        [Fact]
        public async Task GetCocktails_ReturnsOkResult_WithListOfCocktails()
        {
            // Arrange
            var cocktails = new List<CocktailDto>
            {
                new CocktailDto { Id = 1, Name = "Mojito" },
                new CocktailDto { Id = 2, Name = "Martini" }
            };

            _mockService.Setup(s => s.GetAllCocktailsAsync())
                .ReturnsAsync(cocktails);

            // Act
            var result = await _controller.GetCocktails();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnValue = Assert.IsType<List<CocktailDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count);
        }

        // Add new unit tests or update existing ones
    }
    ```

6. **Update Integration Tests**:
    - Ensure your integration tests are updated to test the end-to-end functionality of your API.

    ```csharp
    public class CocktailRecipeServiceIntegrationTests : IClassFixture<CustomWebApplicationFactory<TestStartup>>
    {
        private readonly CustomWebApplicationFactory<TestStartup> _factory;
        private readonly IMapper _mapper;

        public CocktailRecipeServiceIntegrationTests(CustomWebApplicationFactory<TestStartup> factory)
        {
            _factory = factory;

            var mockMapper = new MapperConfiguration(cfg =>
            {
                cfg.AddProfile(new CocktailChooser.API.Mappings.MappingProfile());
            });
            _mapper = mockMapper.CreateMapper();
        }

        private CocktailChooserContext GetInMemoryContext(string databaseName)
        {
            var options = new DbContextOptionsBuilder<CocktailChooserContext>()
                .UseInMemoryDatabase(databaseName)
                .Options;
            return new CocktailChooserContext(options);
        }

        private void SeedDatabase(CocktailChooserContext context)
        {
            context.CocktailRecipes.AddRange(new List<CocktailRecipe>
            {
                new CocktailRecipe { CocktailId = 1, StepNumber = 1, Instruction = "Add ice" },
                new CocktailRecipe { CocktailId = 1, StepNumber = 2, Instruction = "Pour vodka" }
            });
            context.SaveChanges();
        }

        [Fact]
        public async Task GetCocktailRecipeByIdAsync_ReturnsRecipe_WhenRecipeExists()
        {
            // Arrange
            var context = GetInMemoryContext("TestDatabase1");
            SeedDatabase(context);
            var service = new CocktailRecipeService(context, _mapper);

            // Act
            var result = await service.GetCocktailRecipeByIdAsync(1, 1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Add ice", result.Instruction);
        }

        // Add new integration tests or update existing ones
    }
    ```

### Summary
- **Update Models and DTOs**: Reflect changes in your business models and data transfer objects.
- **Update AutoMapper Profile**: Ensure mappings are up-to-date.
- **Modify Services**: Add or update business logic.
- **Update Controllers**: Handle API requests.
- **Write/Update Unit Tests**: Ensure unit tests cover new and modified functionality.
- **Update Integration Tests**: Ensure end-to-end functionality works as expected.

This guide should help you through the process of updating your API while ensuring all components and tests remain consistent and functional.
