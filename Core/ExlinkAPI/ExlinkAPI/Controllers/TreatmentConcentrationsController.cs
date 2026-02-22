using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TreatmentConcentrationsController : ControllerBase
    {
        private readonly ITreatmentConcentrationRepository _repository;

        public TreatmentConcentrationsController(ITreatmentConcentrationRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentConcentrationDto>>> GetTreatmentConcentrations()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentConcentrationDto>> GetTreatmentConcentration(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatmentConcentration(Guid id, TreatmentConcentrationDto dto)
        {
            if (id != dto.ConcentrationUnitId) return BadRequest();

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
        public async Task<ActionResult<TreatmentConcentrationDto>> PostTreatmentConcentration(TreatmentConcentrationDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetTreatmentConcentration), new { id = created.ConcentrationUnitId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatmentConcentration(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}