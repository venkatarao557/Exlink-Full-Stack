using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WeightUnitAlternatesController : ControllerBase
    {
        private readonly IWeightUnitAlternateRepository _repository;

        public WeightUnitAlternatesController(IWeightUnitAlternateRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeightUnitAlternateDto>>> GetWeightUnitAlternates()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<WeightUnitAlternateDto>> GetWeightUnitAlternate(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutWeightUnitAlternate(Guid id, WeightUnitAlternateDto dto)
        {
            if (id != dto.WeightUnitAltId) return BadRequest();

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
        public async Task<ActionResult<WeightUnitAlternateDto>> PostWeightUnitAlternate(WeightUnitAlternateDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetWeightUnitAlternate), new { id = created.WeightUnitAltId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWeightUnitAlternate(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}