using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PortsController : ControllerBase
    {
        private readonly IPortRepository _repository;

        public PortsController(IPortRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<PortDto>>> GetPorts()
        {
            var ports = await _repository.GetAllAsync();
            return Ok(ports);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PortDto>> GetPort(Guid id)
        {
            var port = await _repository.GetByIdAsync(id);
            if (port == null) return NotFound();
            return Ok(port);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutPort(Guid id, PortDto portDto)
        {
            var updated = await _repository.UpdateAsync(id, portDto);
            if (!updated) return NotFound();
            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<PortDto>> PostPort(PortDto portDto)
        {
            var result = await _repository.CreateAsync(portDto);
            return CreatedAtAction(nameof(GetPort), new { id = result.PortId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePort(Guid id)
        {
            var deleted = await _repository.DeleteAsync(id);
            if (!deleted) return NotFound();
            return NoContent();
        }
    }
}