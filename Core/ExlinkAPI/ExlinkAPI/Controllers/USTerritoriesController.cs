using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class USTerritoriesController : ControllerBase
    {
        private readonly IUsTerritoryRepository _repository;

        public USTerritoriesController(IUsTerritoryRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UsTerritoryDto>>> GetUsterritories()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<UsTerritoryDto>> GetUsterritory(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsterritory(Guid id, UsTerritoryDto dto)
        {
            if (id != dto.UsTerritoryId) return BadRequest();

            try
            {
                await _repository.UpdateAsync(dto);
            }
            catch (Exception)
            {
                if (!await _repository.ExistsAsync(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<UsTerritoryDto>> PostUsterritory(UsTerritoryDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetUsterritory), new { id = created.UsTerritoryId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsterritory(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}