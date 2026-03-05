using CocktailChooser.API.Auth;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace CocktailChooser.Tests.Controllers;

public class AdminMaintenanceControllerTests
{
    private readonly Mock<IAdminMaintenanceService> _serviceMock;
    private readonly Mock<ICurrentUserContext> _currentUserContextMock;
    private readonly AdminMaintenanceController _controller;

    public AdminMaintenanceControllerTests()
    {
        _serviceMock = new Mock<IAdminMaintenanceService>();
        _currentUserContextMock = new Mock<ICurrentUserContext>();
        _controller = new AdminMaintenanceController(_serviceMock.Object, _currentUserContextMock.Object);
    }

    [Fact]
    public async Task GetIngredientDuplicates_ReturnsForbid_WhenNotAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(2);

        var result = await _controller.GetIngredientDuplicates();

        var status = Assert.IsType<StatusCodeResult>(result.Result);
        Assert.Equal(403, status.StatusCode);
    }

    [Fact]
    public async Task GetIngredientDuplicates_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.GetIngredientDuplicateGroupsAsync())
            .ReturnsAsync(new IngredientDuplicateGroupsResponseDto
            {
                Groups = new List<IngredientDuplicateGroupDto>
                {
                    new()
                    {
                        NormalizedName = "club soda",
                        Candidates = new List<IngredientDuplicateCandidateDto>
                        {
                            new() { IngredientId = 2, Name = "Club Soda" }
                        }
                    }
                }
            });

        var result = await _controller.GetIngredientDuplicates();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<IngredientDuplicateGroupsResponseDto>(ok.Value);
        Assert.Single(payload.Groups);
        Assert.Equal("club soda", payload.Groups[0].NormalizedName);
    }

    [Fact]
    public async Task GetCocktailDuplicates_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.GetCocktailDuplicateGroupsAsync())
            .ReturnsAsync(new CocktailDuplicateGroupsResponseDto
            {
                Groups = new List<CocktailDuplicateGroupDto>
                {
                    new()
                    {
                        NormalizedName = "martini",
                        Candidates = new List<CocktailDuplicateCandidateDto>
                        {
                            new() { CocktailId = 101, Name = "Martini", CocktailSourceId = 1 }
                        }
                    }
                }
            });

        var result = await _controller.GetCocktailDuplicates();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<CocktailDuplicateGroupsResponseDto>(ok.Value);
        Assert.Single(payload.Groups);
        Assert.Equal("martini", payload.Groups[0].NormalizedName);
    }

    [Fact]
    public async Task MergeIngredient_ReturnsBadRequest_WhenValidationFails()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.MergeIngredientAsync(It.IsAny<IngredientMergeRequestDto>(), 1))
            .ThrowsAsync(new ArgumentException("ids must differ"));

        var result = await _controller.MergeIngredient(new IngredientMergeRequestDto
        {
            KeepIngredientId = 5,
            RemoveIngredientId = 5
        });

        Assert.IsType<BadRequestObjectResult>(result.Result);
    }

    [Fact]
    public async Task MergeIngredient_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.MergeIngredientAsync(It.IsAny<IngredientMergeRequestDto>(), 1))
            .ReturnsAsync(new IngredientMergeResultDto
            {
                KeepIngredientId = 5,
                RemoveIngredientId = 6,
                CocktailRowsRepointed = 12,
                UserRowsRemovedFromSource = 4
            });

        var result = await _controller.MergeIngredient(new IngredientMergeRequestDto
        {
            KeepIngredientId = 5,
            RemoveIngredientId = 6
        });

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<IngredientMergeResultDto>(ok.Value);
        Assert.Equal(5, payload.KeepIngredientId);
        Assert.Equal(6, payload.RemoveIngredientId);
    }

    [Fact]
    public async Task MergeCocktail_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.MergeCocktailAsync(It.IsAny<CocktailMergeRequestDto>(), 1))
            .ReturnsAsync(new CocktailMergeResultDto
            {
                KeepCocktailId = 11,
                RemoveCocktailId = 12,
                IngredientRowsInsertedToKeep = 4,
                TryLogRowsRepointed = 2
            });

        var result = await _controller.MergeCocktail(new CocktailMergeRequestDto
        {
            KeepCocktailId = 11,
            RemoveCocktailId = 12
        });

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<CocktailMergeResultDto>(ok.Value);
        Assert.Equal(11, payload.KeepCocktailId);
        Assert.Equal(12, payload.RemoveCocktailId);
    }

    [Fact]
    public async Task PreviewIngredientMerge_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.PreviewIngredientMergeAsync(It.IsAny<IngredientMergeRequestDto>()))
            .ReturnsAsync(new IngredientMergePreviewDto
            {
                KeepIngredientId = 60,
                RemoveIngredientId = 86,
                CocktailRowsWouldRepoint = 4,
                CocktailDuplicateRowsWouldDelete = 1,
                UserRowsWouldRemoveFromSource = 2
            });

        var result = await _controller.PreviewIngredientMerge(new IngredientMergeRequestDto
        {
            KeepIngredientId = 60,
            RemoveIngredientId = 86
        });

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<IngredientMergePreviewDto>(ok.Value);
        Assert.Equal(60, payload.KeepIngredientId);
        Assert.Equal(86, payload.RemoveIngredientId);
        Assert.Equal(1, payload.CocktailDuplicateRowsWouldDelete);
    }

    [Fact]
    public async Task PreviewCocktailMerge_ReturnsOk_WhenAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.PreviewCocktailMergeAsync(It.IsAny<CocktailMergeRequestDto>()))
            .ReturnsAsync(new CocktailMergePreviewDto
            {
                KeepCocktailId = 11,
                RemoveCocktailId = 12,
                IngredientRowsWouldInsertToKeep = 3,
                TryLogRowsWouldRepoint = 2
            });

        var result = await _controller.PreviewCocktailMerge(new CocktailMergeRequestDto
        {
            KeepCocktailId = 11,
            RemoveCocktailId = 12
        });

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<CocktailMergePreviewDto>(ok.Value);
        Assert.Equal(11, payload.KeepCocktailId);
        Assert.Equal(12, payload.RemoveCocktailId);
        Assert.Equal(3, payload.IngredientRowsWouldInsertToKeep);
    }
}
