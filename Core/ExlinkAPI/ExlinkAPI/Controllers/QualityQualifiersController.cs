using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QualityQualifiersController : ControllerBase
    {
        private readonly IQualityQualifierRepository _repository;

        public QualityQualifiersController(IQualityQualifierRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<QualityQualifierDto>>> GetQualityQualifiers()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<QualityQualifierDto>> GetQualityQualifier(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutQualityQualifier(Guid id, QualityQualifierDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<QualityQualifierDto>> PostQualityQualifier(QualityQualifierDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetQualityQualifier), new { id = result.QualityQualifierId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQualityQualifier(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}