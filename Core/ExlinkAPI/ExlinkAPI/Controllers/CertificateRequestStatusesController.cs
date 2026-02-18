using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificateRequestStatusesController : ControllerBase
    {
        private readonly ICertificateRequestStatusRepository _repository;

        public CertificateRequestStatusesController(ICertificateRequestStatusRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificateRequestStatusDto>>> GetStatuses()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CertificateRequestStatusDto>> GetStatus(Guid id)
        {
            var status = await _repository.GetByIdAsync(id);
            if (status == null) return NotFound();
            return Ok(status);
        }

        [HttpPost]
        public async Task<ActionResult<CertificateRequestStatusDto>> CreateStatus(CertificateRequestStatusDto statusDto)
        {
            if (await _repository.CodeExistsAsync(statusDto.StatusCode))
            {
                return Conflict("Status code already exists.");
            }

            var result = await _repository.CreateAsync(statusDto);
            return CreatedAtAction(nameof(GetStatus), new { id = result.RequestStatusId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateStatus(Guid id, CertificateRequestStatusDto statusDto)
        {
            if (id != statusDto.RequestStatusId) return BadRequest();

            var success = await _repository.UpdateAsync(id, statusDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteStatus(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}