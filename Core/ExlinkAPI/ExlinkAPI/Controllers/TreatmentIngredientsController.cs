using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TreatmentIngredientsController : ControllerBase
    {
        private readonly ITreatmentIngredientRepository _repository;

        public TreatmentIngredientsController(ITreatmentIngredientRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentIngredientDto>>> GetTreatmentIngredients()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentIngredientDto>> GetTreatmentIngredient(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();

            return Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatmentIngredient(Guid id, TreatmentIngredientDto dto)
        {
            if (id != dto.IngredientId) return BadRequest();

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
        public async Task<ActionResult<TreatmentIngredientDto>> PostTreatmentIngredient(TreatmentIngredientDto dto)
        {
            var created = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetTreatmentIngredient), new { id = created.IngredientId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatmentIngredient(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}