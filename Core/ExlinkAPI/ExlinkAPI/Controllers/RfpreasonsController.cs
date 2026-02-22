using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RfpreasonsController : ControllerBase
    {
        private readonly IRfpreasonRepository _repository;

        public RfpreasonsController(IRfpreasonRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RfpreasonDto>>> GetRfpreasons()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<RfpreasonDto>> GetRfpreason(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRfpreason(Guid id, RfpreasonDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<RfpreasonDto>> PostRfpreason(RfpreasonDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetRfpreason), new { id = result.ReasonId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRfpreason(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}