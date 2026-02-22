using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UnitOfMeasuresController : ControllerBase
    {
        private readonly IUnitOfMeasureRepository _repository;

        public UnitOfMeasuresController(IUnitOfMeasureRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UnitOfMeasureDto>>> GetUnitOfMeasures()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<UnitOfMeasureDto>> GetUnitOfMeasure(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutUnitOfMeasure(Guid id, UnitOfMeasureDto dto)
        {
            if (id != dto.UnitOfMeasureId) return BadRequest();

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
        public async Task<ActionResult<UnitOfMeasureDto>> PostUnitOfMeasure(UnitOfMeasureDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetUnitOfMeasure), new { id = created.UnitOfMeasureId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUnitOfMeasure(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}