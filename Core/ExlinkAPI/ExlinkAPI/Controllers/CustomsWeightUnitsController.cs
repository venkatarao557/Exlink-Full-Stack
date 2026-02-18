using ExlinkAPI.Models;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomsWeightUnitsController : ControllerBase
    {
        private readonly ICustomsWeightUnitRepository _repository;

        public CustomsWeightUnitsController(ICustomsWeightUnitRepository repository)
        {
            _repository = repository;
        }

        // GET: api/CustomsWeightUnits
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomsWeightUnit>>> GetCustomsWeightUnits()
        {
            var units = await _repository.GetAllAsync();
            return Ok(units);
        }

        // GET: api/CustomsWeightUnits/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomsWeightUnit>> GetCustomsWeightUnit(Guid id)
        {
            var customsWeightUnit = await _repository.GetByIdAsync(id);

            if (customsWeightUnit == null)
            {
                return NotFound();
            }

            return Ok(customsWeightUnit);
        }

        // PUT: api/CustomsWeightUnits/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomsWeightUnit(Guid id, CustomsWeightUnit customsWeightUnit)
        {
            if (id != customsWeightUnit.CustomsWeightId)
            {
                return BadRequest();
            }

            try
            {
                await _repository.UpdateAsync(customsWeightUnit);
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

        // POST: api/CustomsWeightUnits
        [HttpPost]
        public async Task<ActionResult<CustomsWeightUnit>> PostCustomsWeightUnit(CustomsWeightUnit customsWeightUnit)
        {
            await _repository.AddAsync(customsWeightUnit);
            return CreatedAtAction("GetCustomsWeightUnit", new { id = customsWeightUnit.CustomsWeightId }, customsWeightUnit);
        }

        // DELETE: api/CustomsWeightUnits/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomsWeightUnit(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}