using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CurrenciesController : ControllerBase
    {
        private readonly ICurrencyRepository _repository;

        public CurrenciesController(ICurrencyRepository repository)
        {
            _repository = repository;
        }

        // GET: api/Currencies
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CurrencyDto>>> GetCurrencies()
        {
            return Ok(await _repository.GetAllAsync());
        }

        // GET: api/Currencies/{id}
        [HttpGet("{id:guid}")]
        public async Task<ActionResult<CurrencyDto>> GetCurrency(Guid id)
        {
            var currency = await _repository.GetByIdAsync(id);
            if (currency == null) return NotFound();
            return Ok(currency);
        }

        // GET: api/Currencies/unit/{unit}
        [HttpGet("unit/{unit}")]
        public async Task<ActionResult<CurrencyDto>> GetByUnit(string unit)
        {
            var currency = await _repository.GetByUnitAsync(unit);
            if (currency == null) return NotFound();
            return Ok(currency);
        }

        // POST: api/Currencies
        [HttpPost]
        public async Task<ActionResult<CurrencyDto>> CreateCurrency(CurrencyDto dto)
        {
            if (await _repository.UnitExistsAsync(dto.CurrencyUnit))
            {
                return Conflict("Currency unit already exists.");
            }

            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetCurrency), new { id = result.CurrencyId }, result);
        }

        // PUT: api/Currencies/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCurrency(Guid id, CurrencyDto dto)
        {
            if (id != dto.CurrencyId) return BadRequest();

            var success = await _repository.UpdateAsync(id, dto);
            if (!success) return NotFound();

            return NoContent();
        }

        // DELETE: api/Currencies/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCurrency(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}