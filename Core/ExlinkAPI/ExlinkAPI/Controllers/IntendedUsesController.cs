using ExlinkAPI.Models;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IntendedUsesController : ControllerBase
    {
        private readonly IIntendedUseRepository _repository;

        public IntendedUsesController(IIntendedUseRepository repository)
        {
            _repository = repository;
        }

        // GET: api/IntendedUses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IntendedUseDto>>> GetIntendedUses()
        {
            var entities = await _repository.GetAllAsync();
            var dtos = entities.Select(e => MapToDto(e));
            return Ok(dtos);
        }

        // GET: api/IntendedUses/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<IntendedUseDto>> GetIntendedUse(Guid id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null)
            {
                return NotFound();
            }
            return Ok(MapToDto(entity));
        }

        // PUT: api/IntendedUses/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIntendedUse(Guid id, IntendedUseDto dto)
        {
            if (id != dto.IntendedUseId)
            {
                return BadRequest();
            }

            try
            {
                await _repository.UpdateAsync(MapToEntity(dto));
            }
            catch (Exception)
            {
                if (!await _repository.ExistsAsync(id))
                {
                    return NotFound();
                }
                throw;
            }

            return NoContent();
        }

        // POST: api/IntendedUses
        [HttpPost]
        public async Task<ActionResult<IntendedUseDto>> PostIntendedUse(IntendedUseDto dto)
        {
            var entity = MapToEntity(dto);
            await _repository.AddAsync(entity);

            return CreatedAtAction("GetIntendedUse", new { id = entity.IntendedUseId }, MapToDto(entity));
        }

        // DELETE: api/IntendedUses/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIntendedUse(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }

        // Mapping Helpers
        private static IntendedUseDto MapToDto(IntendedUse e) => new()
        {
            IntendedUseId = e.IntendedUseId,
            UseCode = e.UseCode,
            Description = e.Description
        };

        private static IntendedUse MapToEntity(IntendedUseDto d) => new()
        {
            IntendedUseId = d.IntendedUseId,
            UseCode = d.UseCode,
            Description = d.Description
        };
    }
}