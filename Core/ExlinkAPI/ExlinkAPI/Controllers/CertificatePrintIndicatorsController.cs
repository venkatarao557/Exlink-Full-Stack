using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificatePrintIndicatorsController : ControllerBase
    {
        private readonly ICertificatePrintIndicatorRepository _repository;

        public CertificatePrintIndicatorsController(ICertificatePrintIndicatorRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificatePrintIndicatorDto>>> GetIndicators()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CertificatePrintIndicatorDto>> GetIndicator(Guid id)
        {
            var indicator = await _repository.GetByIdAsync(id);
            if (indicator == null) return NotFound();
            return Ok(indicator);
        }

        [HttpPost]
        public async Task<ActionResult<CertificatePrintIndicatorDto>> CreateIndicator(CertificatePrintIndicatorDto indicatorDto)
        {
            var result = await _repository.CreateAsync(indicatorDto);
            return CreatedAtAction(nameof(GetIndicator), new { id = result.PrintIndicatorId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateIndicator(Guid id, CertificatePrintIndicatorDto indicatorDto)
        {
            if (id != indicatorDto.PrintIndicatorId) return BadRequest();

            var success = await _repository.UpdateAsync(id, indicatorDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIndicator(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}