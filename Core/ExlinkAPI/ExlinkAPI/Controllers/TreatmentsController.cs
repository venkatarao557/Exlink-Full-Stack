using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TreatmentsController : ControllerBase
    {
        private readonly ITreatmentRepository _repository;

        public TreatmentsController(ITreatmentRepository repository)
        {
            _repository = repository;
        }

        // GET: api/Treatments
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentDto>>> GetTreatments()
        {
            return Ok(await _repository.GetAllAsync());
        }

        // GET: api/Treatments/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentDto>> GetTreatment(Guid id)
        {
            var treatment = await _repository.GetByIdAsync(id);
            if (treatment == null) return NotFound();

            return Ok(treatment);
        }

        // PUT: api/Treatments/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatment(Guid id, TreatmentDto treatmentDto)
        {
            if (id != treatmentDto.TreatmentId) return BadRequest();

            try
            {
                await _repository.UpdateAsync(treatmentDto);
            }
            catch (Exception)
            {
                if (!await _repository.ExistsAsync(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // POST: api/Treatments
        [HttpPost]
        public async Task<ActionResult<TreatmentDto>> PostTreatment(TreatmentDto treatmentDto)
        {
            var created = await _repository.CreateAsync(treatmentDto);
            return CreatedAtAction(nameof(GetTreatment), new { id = created.TreatmentId }, created);
        }

        // DELETE: api/Treatments/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatment(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}