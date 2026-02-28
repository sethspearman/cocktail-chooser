using System.Collections.Generic;
using System.Threading.Tasks;
using CocktailChooser.API.Auth;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;
using Moq;
using Xunit;

namespace CocktailChooser.Tests.Controllers
{
    public class CocktailsControllerTests
    {
        private readonly Mock<ICocktailService> _mockService;
        private readonly Mock<ICurrentUserContext> _mockCurrentUserContext;
        private readonly CocktailsController _controller;

        public CocktailsControllerTests()
        {
            _mockService = new Mock<ICocktailService>();
            _mockCurrentUserContext = new Mock<ICurrentUserContext>();
            _controller = new CocktailsController(_mockService.Object, _mockCurrentUserContext.Object);
        }

        [Fact]
        public async Task GetCocktails_ReturnsOkResult_WithListOfCocktails()
        {
            var cocktails = new List<CocktailDto>
            {
                new CocktailDto { Id = 1, Name = "Mojito" },
                new CocktailDto { Id = 2, Name = "Martini" }
            };

            _mockService.Setup(s => s.GetAllCocktailsAsync(null, null, null))
                .ReturnsAsync(cocktails);

            var result = await _controller.GetCocktails();

            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnValue = Assert.IsType<List<CocktailDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count);
        }

        [Fact]
        public async Task GetCocktail_ReturnsNotFound_WhenCocktailDoesNotExist()
        {
            _mockService.Setup(s => s.GetCocktailByIdAsync(1))
                .ReturnsAsync((CocktailDto)null!);

            var result = await _controller.GetCocktail(1);

            Assert.IsType<NotFoundResult>(result.Result);
        }

        [Fact]
        public async Task GetCocktail_ReturnsOkResult_WithCocktailDto()
        {
            var cocktail = new CocktailDto { Id = 1, Name = "Mojito" };
            _mockService.Setup(s => s.GetCocktailByIdAsync(1))
                .ReturnsAsync(cocktail);

            var result = await _controller.GetCocktail(1);

            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var returnValue = Assert.IsType<CocktailDto>(okResult.Value);
            Assert.Equal(cocktail.Name, returnValue.Name);
        }

        [Fact]
        public async Task PostCocktail_ReturnsCreatedAtActionResult_WithCocktailDto()
        {
            var cocktailDto = new CocktailDto { Name = "Mojito" };
            var createdCocktailDto = new CocktailDto { Id = 1, Name = "Mojito" };

            _mockService.Setup(s => s.CreateCocktailAsync(cocktailDto))
                .ReturnsAsync(createdCocktailDto);

            var result = await _controller.PostCocktail(cocktailDto);

            var createdAtActionResult = Assert.IsType<CreatedAtActionResult>(result.Result);
            var returnValue = Assert.IsType<CocktailDto>(createdAtActionResult.Value);
            Assert.Equal(createdCocktailDto.Name, returnValue.Name);
        }

        [Fact]
        public async Task PutCocktail_ReturnsNoContent_WhenCocktailIsUpdated()
        {
            var cocktailDto = new CocktailDto { Id = 1, Name = "Mojito" };

            _mockService.Setup(s => s.UpdateCocktailAsync(cocktailDto))
                .ReturnsAsync(true);

            var result = await _controller.PutCocktail(1, cocktailDto);

            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task DeleteCocktail_ReturnsNoContent_WhenCocktailIsDeleted()
        {
            _mockService.Setup(s => s.DeleteCocktailAsync(1))
                .ReturnsAsync(true);

            var result = await _controller.DeleteCocktail(1);

            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task GetMyPendingCocktails_ReturnsUnauthorized_WhenUserNotAuthenticated()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns((int?)null);

            var result = await _controller.GetMyPendingCocktails();

            Assert.IsType<UnauthorizedResult>(result.Result);
        }

        [Fact]
        public async Task GetMyPendingCocktails_ReturnsOk_WhenUserAuthenticated()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns(42);
            _mockService.Setup(s => s.GetPendingCocktailsForUserAsync(42))
                .ReturnsAsync(new List<CocktailDto>
                {
                    new() { Id = 1, Name = "My Pending Drink" }
                });

            var result = await _controller.GetMyPendingCocktails();

            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var payload = Assert.IsType<List<CocktailDto>>(okResult.Value);
            Assert.Single(payload);
            Assert.Equal("My Pending Drink", payload[0].Name);
        }

        [Fact]
        public async Task PreviewFromText_ReturnsOk_WithPreviewPayload()
        {
            var request = new CocktailTextPreviewRequestDto { RawText = "Name: Test" };
            _mockService.Setup(s => s.PreviewFromTextAsync(request))
                .ReturnsAsync(new CocktailTextPreviewResponseDto
                {
                    Name = "Test",
                    Errors = new List<string>()
                });

            var result = await _controller.PreviewFromText(request);

            var okResult = Assert.IsType<OkObjectResult>(result.Result);
            var payload = Assert.IsType<CocktailTextPreviewResponseDto>(okResult.Value);
            Assert.Equal("Test", payload.Name);
        }

        [Fact]
        public async Task SubmitFromText_ReturnsUnauthorized_WhenUserNotAuthenticated()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns((int?)null);

            var result = await _controller.SubmitFromText(new CocktailTextSubmitRequestDto { RawText = "Name: X" });

            Assert.IsType<UnauthorizedResult>(result.Result);
        }

        [Fact]
        public async Task SubmitFromText_ReturnsBadRequest_OnValidationFailure()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns(42);
            _mockService.Setup(s => s.SubmitFromTextAsync(It.IsAny<CocktailTextSubmitRequestDto>(), 42))
                .ThrowsAsync(new System.ArgumentException("Missing required header"));

            var result = await _controller.SubmitFromText(new CocktailTextSubmitRequestDto { RawText = "Bad payload" });

            var badRequest = Assert.IsType<BadRequestObjectResult>(result.Result);
            var message = Assert.IsType<string>(badRequest.Value);
            Assert.Contains("Missing required header", message);
        }

        [Fact]
        public async Task ApproveCocktail_ReturnsForbid_WhenUserIsNotAdmin()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns(42);

            var result = await _controller.ApproveCocktail(10);

            Assert.IsType<ForbidResult>(result);
        }

        [Fact]
        public async Task ApproveCocktail_ReturnsNoContent_WhenAdminApproves()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns(1);
            _mockService.Setup(s => s.ApproveCocktailAsync(10)).ReturnsAsync(true);

            var result = await _controller.ApproveCocktail(10);

            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task RejectCocktail_ReturnsNoContent_WhenAdminRejects()
        {
            _mockCurrentUserContext.SetupGet(x => x.UserId).Returns(1);
            _mockService.Setup(s => s.RejectCocktailAsync(10, true)).ReturnsAsync(true);

            var result = await _controller.RejectCocktail(10, true);

            Assert.IsType<NoContentResult>(result);
        }
    }
}
