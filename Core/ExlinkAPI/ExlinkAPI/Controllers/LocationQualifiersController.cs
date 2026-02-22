using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationQualifiersController : ControllerBase
    {
        private readonly ILocationQualifierRepository _repository;

        public LocationQualifiersController(ILocationQualifierRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<LocationQualifierDto>>> GetLocationQualifiers()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<LocationQualifierDto>> GetLocationQualifier(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutLocationQualifier(Guid id, LocationQualifierDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<LocationQualifierDto>> PostLocationQualifier(LocationQualifierDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetLocationQualifier), new { id = result.LocationQualId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLocationQualifier(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}