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
}
