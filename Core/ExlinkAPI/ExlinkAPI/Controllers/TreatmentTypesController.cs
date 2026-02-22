using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TreatmentTypesController : ControllerBase
    {
        private readonly ITreatmentTypeRepository _repository;

        public TreatmentTypesController(ITreatmentTypeRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentTypeDto>>> GetTreatmentTypes()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentTypeDto>> GetTreatmentType(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatmentType(Guid id, TreatmentTypeDto dto)
        {
            if (id != dto.TreatmentTypeId) return BadRequest();

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
        public async Task<ActionResult<TreatmentTypeDto>> PostTreatmentType(TreatmentTypeDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetTreatmentType), new { id = created.TreatmentTypeId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatmentType(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}