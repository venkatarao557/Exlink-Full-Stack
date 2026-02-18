using ExlinkAPI.Models;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeclarationIndicatorsController : ControllerBase
    {
        private readonly IDeclarationIndicatorRepository _repository;

        public DeclarationIndicatorsController(IDeclarationIndicatorRepository repository)
        {
            _repository = repository;
        }

        // GET: api/DeclarationIndicators
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DeclarationIndicatorDto>>> GetDeclarationIndicators()
        {
            var indicators = await _repository.GetAllAsync();
            var dtos = indicators.Select(i => MapToDto(i));
            return Ok(dtos);
        }

        // GET: api/DeclarationIndicators/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<DeclarationIndicatorDto>> GetDeclarationIndicator(Guid id)
        {
            var indicator = await _repository.GetByIdAsync(id);
            if (indicator == null)
            {
                return NotFound();
            }
            return Ok(MapToDto(indicator));
        }

        // PUT: api/DeclarationIndicators/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDeclarationIndicator(Guid id, DeclarationIndicatorDto dto)
        {
            if (id != dto.DeclarationId)
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

        // POST: api/DeclarationIndicators
        [HttpPost]
        public async Task<ActionResult<DeclarationIndicatorDto>> PostDeclarationIndicator(DeclarationIndicatorDto dto)
        {
            var indicator = MapToEntity(dto);
            await _repository.AddAsync(indicator);

            return CreatedAtAction("GetDeclarationIndicator", new { id = indicator.DeclarationId }, MapToDto(indicator));
        }

        // DELETE: api/DeclarationIndicators/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDeclarationIndicator(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }

        // Mapping Helpers
        private static DeclarationIndicatorDto MapToDto(DeclarationIndicator e) => new()
        {
            DeclarationId = e.DeclarationId,
            IndicatorCode = e.IndicatorCode,
            Description = e.Description
        };

        private static DeclarationIndicator MapToEntity(DeclarationIndicatorDto d) => new()
        {
            DeclarationId = d.DeclarationId,
            IndicatorCode = d.IndicatorCode,
            Description = d.Description
        };
    }
}