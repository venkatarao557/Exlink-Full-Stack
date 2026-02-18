using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificateReasonsController : ControllerBase
    {
        private readonly ICertificateReasonRepository _repository;

        public CertificateReasonsController(ICertificateReasonRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificateReasonDto>>> GetReasons()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id:guid}")]
        public async Task<ActionResult<CertificateReasonDto>> GetReasonById(Guid id)
        {
            var reason = await _repository.GetByIdAsync(id);
            if (reason == null) return NotFound();
            return Ok(reason);
        }

        [HttpGet("code/{code:int}")]
        public async Task<ActionResult<CertificateReasonDto>> GetReasonByCode(int code)
        {
            var reason = await _repository.GetByCodeAsync(code);
            if (reason == null) return NotFound();
            return Ok(reason);
        }

        [HttpPost]
        public async Task<ActionResult<CertificateReasonDto>> CreateReason(CertificateReasonDto reasonDto)
        {
            if (await _repository.ExistsAsync(reasonDto.ReasonCode))
            {
                return Conflict("Reason code already exists.");
            }

            var result = await _repository.CreateAsync(reasonDto);
            return CreatedAtAction(nameof(GetReasonById), new { id = result.ReasonId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateReason(Guid id, CertificateReasonDto reasonDto)
        {
            if (id != reasonDto.ReasonId) return BadRequest();

            var success = await _repository.UpdateAsync(id, reasonDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReason(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}