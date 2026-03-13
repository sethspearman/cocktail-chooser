using CocktailChooser.API.Auth;
using CocktailChooser.API.Controllers;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace CocktailChooser.Tests.Controllers;

public class CollectionsControllerTests
{
    private readonly Mock<ICollectionService> _serviceMock;
    private readonly Mock<ICurrentUserContext> _currentUserContextMock;
    private readonly CollectionsController _controller;

    public CollectionsControllerTests()
    {
        _serviceMock = new Mock<ICollectionService>();
        _currentUserContextMock = new Mock<ICurrentUserContext>();
        _controller = new CollectionsController(_serviceMock.Object, _currentUserContextMock.Object);
    }

    [Fact]
    public async Task GetCollections_ReturnsOk()
    {
        _serviceMock.Setup(x => x.GetCollectionsAsync(true, null))
            .ReturnsAsync(new List<CollectionDto> { new() { Id = 1, Name = "Favorites" } });

        var result = await _controller.GetCollections();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<List<CollectionDto>>(ok.Value);
        Assert.Single(payload);
    }

    [Fact]
    public async Task GetMyCollections_ReturnsUnauthorized_WhenAnonymous()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns((int?)null);

        var result = await _controller.GetMyCollections();

        Assert.IsType<UnauthorizedResult>(result.Result);
    }

    [Fact]
    public async Task GetMyCollections_ReturnsCurrentUsersCollections()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(42);
        _serviceMock.Setup(x => x.GetCollectionsAsync(true, 42))
            .ReturnsAsync(new List<CollectionDto> { new() { Id = 2, Name = "Mine", OwnerUserId = 42 } });

        var result = await _controller.GetMyCollections();

        var ok = Assert.IsType<OkObjectResult>(result.Result);
        var payload = Assert.IsType<List<CollectionDto>>(ok.Value);
        Assert.Single(payload);
        Assert.Equal(42, payload[0].OwnerUserId);
    }

    [Fact]
    public async Task PostCollection_ForUserOwnedCollection_SetsCurrentUserWhenMissing()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(42);
        _serviceMock.Setup(x => x.CreateCollectionAsync(It.IsAny<CollectionDto>()))
            .ReturnsAsync((CollectionDto dto) =>
            {
                dto.Id = 10;
                return dto;
            });

        var result = await _controller.PostCollection(new CollectionDto
        {
            Name = "Favorites",
            IsSystemCollection = 0
        });

        var created = Assert.IsType<CreatedAtActionResult>(result.Result);
        var payload = Assert.IsType<CollectionDto>(created.Value);
        Assert.Equal(42, payload.OwnerUserId);
    }

    [Fact]
    public async Task PostCollection_ForSystemCollection_ForbidsNonAdmin()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(42);

        var result = await _controller.PostCollection(new CollectionDto
        {
            Name = "Editor Picks",
            IsSystemCollection = 1
        });

        Assert.IsType<ForbidResult>(result.Result);
    }

    [Fact]
    public async Task PutCollection_ForbidsNonOwnerForUserCollection()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(99);
        _serviceMock.Setup(x => x.GetCollectionByIdAsync(7))
            .ReturnsAsync(new CollectionDto
            {
                Id = 7,
                Name = "Favorites",
                OwnerUserId = 42,
                IsSystemCollection = 0
            });

        var result = await _controller.PutCollection(7, new CollectionDto
        {
            Id = 7,
            Name = "Changed",
            OwnerUserId = 99,
            IsSystemCollection = 0
        });

        Assert.IsType<ForbidResult>(result);
    }

    [Fact]
    public async Task PutCollection_PreservesOwnershipAndSystemFlags()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(42);
        _serviceMock.Setup(x => x.GetCollectionByIdAsync(7))
            .ReturnsAsync(new CollectionDto
            {
                Id = 7,
                Name = "Favorites",
                OwnerUserId = 42,
                IsSystemCollection = 0
            });
        _serviceMock.Setup(x => x.UpdateCollectionAsync(It.IsAny<CollectionDto>()))
            .ReturnsAsync(true);

        var result = await _controller.PutCollection(7, new CollectionDto
        {
            Id = 7,
            Name = "Changed",
            OwnerUserId = 123,
            IsSystemCollection = 1
        });

        Assert.IsType<NoContentResult>(result);
        _serviceMock.Verify(x => x.UpdateCollectionAsync(It.Is<CollectionDto>(dto =>
            dto.Id == 7 &&
            dto.Name == "Changed" &&
            dto.OwnerUserId == 42 &&
            dto.IsSystemCollection == 0)), Times.Once);
    }

    [Fact]
    public async Task DeleteCollection_AllowsAdminForSystemCollection()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(1);
        _serviceMock.Setup(x => x.GetCollectionByIdAsync(5))
            .ReturnsAsync(new CollectionDto
            {
                Id = 5,
                Name = "Editor Picks",
                IsSystemCollection = 1
            });
        _serviceMock.Setup(x => x.DeleteCollectionAsync(5)).ReturnsAsync(true);

        var result = await _controller.DeleteCollection(5);

        Assert.IsType<NoContentResult>(result);
    }

    [Fact]
    public async Task AddCocktail_ForbidsNonOwner()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(99);
        _serviceMock.Setup(x => x.GetCollectionByIdAsync(3))
            .ReturnsAsync(new CollectionDto
            {
                Id = 3,
                Name = "Favorites",
                OwnerUserId = 42,
                IsSystemCollection = 0
            });

        var result = await _controller.AddCocktail(3, new CollectionCocktailUpsertDto { CocktailId = 13 });

        Assert.IsType<ForbidResult>(result);
    }

    [Fact]
    public async Task RemoveCocktail_ReturnsNotFound_WhenLinkMissing()
    {
        _currentUserContextMock.SetupGet(x => x.UserId).Returns(42);
        _serviceMock.Setup(x => x.GetCollectionByIdAsync(3))
            .ReturnsAsync(new CollectionDto
            {
                Id = 3,
                Name = "Favorites",
                OwnerUserId = 42,
                IsSystemCollection = 0
            });
        _serviceMock.Setup(x => x.RemoveCocktailAsync(3, 13)).ReturnsAsync(false);

        var result = await _controller.RemoveCocktail(3, 13);

        Assert.IsType<NotFoundResult>(result);
    }
}
