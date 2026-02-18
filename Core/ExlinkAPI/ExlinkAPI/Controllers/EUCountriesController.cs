using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Implementations;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EUCountriesController : ControllerBase
    {
        private readonly IEUCountryRepository _repository;

        public EUCountriesController(IEUCountryRepository repository)
        {
            _repository = repository;
        }

        // GET: api/EUCountries
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EUCountryDto>>> GetEucountries()
        {
            var entities = await _repository.GetAllAsync();
            var dtos = entities.Select(e => MapToDto(e));
            return Ok(dtos);
        }

        // GET: api/EUCountries/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<EUCountryDto>> GetEUCountry(Guid id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null)
            {
                return NotFound();
            }
            return Ok(MapToDto(entity));
        }

        // PUT: api/EUCountries/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEUCountry(Guid id, EUCountryDto dto)
        {
            if (id != dto.EUCountryId)
            {
                return BadRequest();
            }

            try
            {
                await _repository.UpdateAsync(MapToEntity(dto));
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

        // POST: api/EUCountries
        [HttpPost]
        public async Task<ActionResult<EUCountryDto>> PostEUCountry(EUCountryDto dto)
        {
            var entity = MapToEntity(dto);
            await _repository.AddAsync(entity);

            return CreatedAtAction("GetEUCountry", new { id = entity.EUCountryId }, MapToDto(entity));
        }

        // DELETE: api/EUCountries/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEUCountry(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }

        // Mapping Logic
        private static EUCountryDto MapToDto(EUCountry e) => new()
        {
            EUCountryId = e.EUCountryId,
            EUCountryCode = e.EUCountryCode,
            EUCountryName = e.EUCountryName
        };

        private static EUCountry MapToEntity(EUCountryDto d) => new()
        {
            EUCountryId = d.EUCountryId,
            EUCountryCode = d.EUCountryCode,
            EUCountryName = d.EUCountryName
        };
    }
}