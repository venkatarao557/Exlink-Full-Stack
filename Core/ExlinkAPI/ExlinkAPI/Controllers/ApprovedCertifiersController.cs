using ExlinkAPI.DTOs;

using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ApprovedCertifiersController : ControllerBase
    {
        private readonly IApprovedCertifierRepository _repository;

        public ApprovedCertifiersController(IApprovedCertifierRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ApprovedCertifierDto>>> GetCertifiers()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ApprovedCertifierDto>> GetCertifier(Guid id)
        {
            var certifier = await _repository.GetByIdAsync(id);
            if (certifier == null) return NotFound();
            return Ok(certifier);
        }

        [HttpPost]
        public async Task<ActionResult<ApprovedCertifierDto>> CreateCertifier(ApprovedCertifierDto certifierDto)
        {
            var result = await _repository.CreateAsync(certifierDto);
            return CreatedAtAction(nameof(GetCertifier), new { id = result.CertifierId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCertifier(Guid id, ApprovedCertifierDto certifierDto)
        {
            if (id != certifierDto.CertifierId) return BadRequest();

            var success = await _repository.UpdateAsync(id, certifierDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCertifier(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}