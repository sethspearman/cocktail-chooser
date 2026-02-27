using Xunit;
using Moq;
using Microsoft.AspNetCore.Mvc;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CocktailChooser.Tests.Controllers
{
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

            _mockService.Setup(s => s.GetAllCocktailsAsync(null, null, null))
                .ReturnsAsync(cocktails);

            // Act
            var result = await _controller.GetCocktails();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnValue = Assert.IsType<List<CocktailDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count);
        }

        [Fact]
        public async Task GetCocktail_ReturnsNotFound_WhenCocktailDoesNotExist()
        {
            // Arrange
            _mockService.Setup(s => s.GetCocktailByIdAsync(1))
                .ReturnsAsync((CocktailDto)null);

            // Act
            var result = await _controller.GetCocktail(1);

            // Assert
            Assert.IsType<NotFoundResult>(result.Result);
        }

        [Fact]
        public async Task GetCocktail_ReturnsOkResult_WithCocktailDto()
        {
            // Arrange
            var cocktail = new CocktailDto { Id = 1, Name = "Mojito" };
            _mockService.Setup(s => s.GetCocktailByIdAsync(1))
                .ReturnsAsync(cocktail);

            // Act
            var result = await _controller.GetCocktail(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnValue = Assert.IsType<CocktailDto>(okResult.Value);
            Assert.Equal(cocktail.Name, returnValue.Name);
        }

        [Fact]
        public async Task PostCocktail_ReturnsCreatedAtActionResult_WithCocktailDto()
        {
            // Arrange
            var cocktailDto = new CocktailDto { Name = "Mojito" };
            var createdCocktailDto = new CocktailDto { Id = 1, Name = "Mojito" };

            _mockService.Setup(s => s.CreateCocktailAsync(cocktailDto))
                .ReturnsAsync(createdCocktailDto);

            // Act
            var result = await _controller.PostCocktail(cocktailDto);

            // Assert
            var createdAtActionResult = Assert.IsType<CreatedAtActionResult>(result.Result);
            var returnValue = Assert.IsType<CocktailDto>(createdAtActionResult.Value);
            Assert.Equal(createdCocktailDto.Name, returnValue.Name);
        }

        [Fact]
        public async Task PutCocktail_ReturnsNoContent_WhenCocktailIsUpdated()
        {
            // Arrange
            var cocktailDto = new CocktailDto { Id = 1, Name = "Mojito" };

            _mockService.Setup(s => s.UpdateCocktailAsync(cocktailDto))
                .ReturnsAsync(true);

            // Act
            var result = await _controller.PutCocktail(1, cocktailDto);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task DeleteCocktail_ReturnsNoContent_WhenCocktailIsDeleted()
        {
            // Arrange
            _mockService.Setup(s => s.DeleteCocktailAsync(1))
                .ReturnsAsync(true);

            // Act
            var result = await _controller.DeleteCocktail(1);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }
    }
}
