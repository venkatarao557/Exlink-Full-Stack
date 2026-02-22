using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransportModesController : ControllerBase
    {
        private readonly ITransportModeRepository _repository;

        public TransportModesController(ITransportModeRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TransportModeDto>>> GetTransportModes()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TransportModeDto>> GetTransportMode(Guid id)
        {
            var transportMode = await _repository.GetByIdAsync(id);
            if (transportMode == null) return NotFound();

            return Ok(transportMode);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutTransportMode(Guid id, TransportModeDto transportModeDto)
        {
            if (id != transportModeDto.TransportModeId) return BadRequest();

            try
            {
                await _repository.UpdateAsync(transportModeDto);
            }
            catch (Exception)
            {
                if (!await _repository.ExistsAsync(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<TransportModeDto>> PostTransportMode(TransportModeDto transportModeDto)
        {
            var created = await _repository.CreateAsync(transportModeDto);
            return CreatedAtAction(nameof(GetTransportMode), new { id = created.TransportModeId }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTransportMode(Guid id)
        {
            if (!await _repository.ExistsAsync(id)) return NotFound();

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}