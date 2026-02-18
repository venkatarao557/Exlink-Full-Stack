using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountryCommoditiesController : ControllerBase
    {
        private readonly ICountryCommodityRepository _repository;

        public CountryCommoditiesController(ICountryCommodityRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CountryCommodityDto>>> GetCountryCommodities()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("code/{countryCode}")]
        public async Task<ActionResult<CountryCommodityDto>> GetByCountryCode(string countryCode)
        {
            var mapping = await _repository.GetByCountryCodeAsync(countryCode);
            if (mapping == null) return NotFound();
            return Ok(mapping);
        }

        [HttpPost]
        public async Task<ActionResult<CountryCommodityDto>> CreateMapping(CountryCommodityDto dto)
        {
            if (await _repository.MappingExistsAsync(dto.CountryCode))
            {
                return Conflict("A mapping for this country code already exists.");
            }

            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetByCountryCode), new { countryCode = result.CountryCode }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateMapping(Guid id, CountryCommodityDto dto)
        {
            if (id != dto.CountryCommodityId) return BadRequest();

            var success = await _repository.UpdateAsync(id, dto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMapping(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}