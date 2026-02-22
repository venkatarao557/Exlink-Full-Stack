using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WeightUnitShortsController : ControllerBase
    {
        private readonly IWeightUnitShortRepository _repository;

        public WeightUnitShortsController(IWeightUnitShortRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeightUnitShortDto>>> GetWeightUnitShorts()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<WeightUnitShortDto>> GetWeightUnitShort(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutWeightUnitShort(Guid id, WeightUnitShortDto dto)
        {
            if (id != dto.WeightUnitShortId) return BadRequest();

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
        public async Task<ActionResult<WeightUnitShortDto>> PostWeightUnitShort(WeightUnitShortDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetWeightUnitShort), new { id = created.WeightUnitShortId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWeightUnitShort(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}