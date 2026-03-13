using CocktailChooser.API.Auth;
using CocktailChooser.API.DTOs;
using CocktailChooser.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace CocktailChooser.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CollectionsController : ControllerBase
{
    private readonly ICollectionService _service;
    private readonly ICurrentUserContext _currentUserContext;

    public CollectionsController(ICollectionService service, ICurrentUserContext currentUserContext)
    {
        _service = service;
        _currentUserContext = currentUserContext;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<CollectionDto>>> GetCollections(
        [FromQuery] bool includeSystem = true,
        [FromQuery] int? ownerUserId = null)
    {
        var collections = await _service.GetCollectionsAsync(includeSystem, ownerUserId);
        return Ok(collections);
    }

    [HttpGet("mine")]
    public async Task<ActionResult<IEnumerable<CollectionDto>>> GetMyCollections([FromQuery] bool includeSystem = true)
    {
        if (!_currentUserContext.UserId.HasValue)
        {
            return Unauthorized();
        }

        var collections = await _service.GetCollectionsAsync(includeSystem, _currentUserContext.UserId.Value);
        return Ok(collections);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<CollectionDto>> GetCollection(int id)
    {
        var collection = await _service.GetCollectionByIdAsync(id);
        if (collection is null)
        {
            return NotFound();
        }

        return Ok(collection);
    }

    [HttpGet("{id:int}/cocktails")]
    public async Task<ActionResult<IEnumerable<CollectionCocktailDto>>> GetCollectionCocktails(int id)
    {
        var collection = await _service.GetCollectionByIdAsync(id);
        if (collection is null)
        {
            return NotFound();
        }

        var cocktails = await _service.GetCollectionCocktailsAsync(id);
        return Ok(cocktails);
    }

    [HttpPost]
    public async Task<ActionResult<CollectionDto>> PostCollection(CollectionDto dto)
    {
        if (!CanManageCollection(dto.OwnerUserId, dto.IsSystemCollection))
        {
            return Forbid();
        }

        if (dto.IsSystemCollection == 0)
        {
            dto.OwnerUserId = _currentUserContext.UserId;
        }

        var created = await _service.CreateCollectionAsync(dto);
        return CreatedAtAction(nameof(GetCollection), new { id = created.Id }, created);
    }

    [HttpPut("{id:int}")]
    public async Task<IActionResult> PutCollection(int id, CollectionDto dto)
    {
        if (id != dto.Id)
        {
            return BadRequest();
        }

        var existing = await _service.GetCollectionByIdAsync(id);
        if (existing is null)
        {
            return NotFound();
        }

        if (!CanManageExistingCollection(existing))
        {
            return Forbid();
        }

        dto.OwnerUserId = existing.OwnerUserId;
        dto.IsSystemCollection = existing.IsSystemCollection;

        var updated = await _service.UpdateCollectionAsync(dto);
        if (!updated)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpDelete("{id:int}")]
    public async Task<IActionResult> DeleteCollection(int id)
    {
        var existing = await _service.GetCollectionByIdAsync(id);
        if (existing is null)
        {
            return NotFound();
        }

        if (!CanManageExistingCollection(existing))
        {
            return Forbid();
        }

        var deleted = await _service.DeleteCollectionAsync(id);
        if (!deleted)
        {
            return NotFound();
        }

        return NoContent();
    }

    [HttpPost("{id:int}/cocktails")]
    public async Task<IActionResult> AddCocktail(int id, CollectionCocktailUpsertDto dto)
    {
        var existing = await _service.GetCollectionByIdAsync(id);
        if (existing is null)
        {
            return NotFound();
        }

        if (!CanManageExistingCollection(existing))
        {
            return Forbid();
        }

        await _service.AddCocktailAsync(id, dto.CocktailId);
        return NoContent();
    }

    [HttpDelete("{id:int}/cocktails/{cocktailId:int}")]
    public async Task<IActionResult> RemoveCocktail(int id, int cocktailId)
    {
        var existing = await _service.GetCollectionByIdAsync(id);
        if (existing is null)
        {
            return NotFound();
        }

        if (!CanManageExistingCollection(existing))
        {
            return Forbid();
        }

        var removed = await _service.RemoveCocktailAsync(id, cocktailId);
        if (!removed)
        {
            return NotFound();
        }

        return NoContent();
    }

    private bool CanManageCollection(int? ownerUserId, int isSystemCollection)
    {
        if (isSystemCollection == 1)
        {
            return IsAdminUser();
        }

        return _currentUserContext.UserId.HasValue
               && (!ownerUserId.HasValue || ownerUserId.Value == _currentUserContext.UserId.Value);
    }

    private bool CanManageExistingCollection(CollectionDto collection)
    {
        if (collection.IsSystemCollection == 1)
        {
            return IsAdminUser();
        }

        return _currentUserContext.UserId.HasValue
               && collection.OwnerUserId.GetValueOrDefault() == _currentUserContext.UserId.Value;
    }

    private bool IsAdminUser()
    {
        return _currentUserContext.UserId.HasValue && _currentUserContext.UserId.Value == 1;
    }
}
