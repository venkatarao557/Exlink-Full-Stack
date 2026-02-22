using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegulatoryDocumentsController : ControllerBase
    {
        private readonly IRegulatoryDocumentRepository _repository;

        public RegulatoryDocumentsController(IRegulatoryDocumentRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RegulatoryDocumentDto>>> GetRegulatoryDocuments()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<RegulatoryDocumentDto>> GetRegulatoryDocument(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutRegulatoryDocument(Guid id, RegulatoryDocumentDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<RegulatoryDocumentDto>> PostRegulatoryDocument(RegulatoryDocumentDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetRegulatoryDocument), new { id = result.RegulatoryDocId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRegulatoryDocument(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}