using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountriesController : ControllerBase
    {
        private readonly ICountryRepository _repository;

        public CountriesController(ICountryRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CountryDto>>> GetCountries()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id:guid}")]
        public async Task<ActionResult<CountryDto>> GetCountry(Guid id)
        {
            var country = await _repository.GetByIdAsync(id);
            if (country == null) return NotFound();
            return Ok(country);
        }

        [HttpGet("code/{code}")]
        public async Task<ActionResult<CountryDto>> GetCountryByCode(string code)
        {
            var country = await _repository.GetByCodeAsync(code);
            if (country == null) return NotFound();
            return Ok(country);
        }

        [HttpPost]
        public async Task<ActionResult<CountryDto>> CreateCountry(CountryDto countryDto)
        {
            if (await _repository.CodeExistsAsync(countryDto.CountryCode))
            {
                return Conflict("Country code already exists.");
            }

            var result = await _repository.CreateAsync(countryDto);
            return CreatedAtAction(nameof(GetCountry), new { id = result.CountryId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCountry(Guid id, CountryDto countryDto)
        {
            if (id != countryDto.CountryId) return BadRequest();

            var success = await _repository.UpdateAsync(id, countryDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCountry(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}