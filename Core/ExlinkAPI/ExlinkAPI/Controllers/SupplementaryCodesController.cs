using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SupplementaryCodesController : ControllerBase
    {
        private readonly ISupplementaryCodeRepository _repository;

        public SupplementaryCodesController(ISupplementaryCodeRepository repository)
        {
            _repository = repository;
        }

        // GET: api/SupplementaryCodes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SupplementaryCode>>> GetSupplementaryCodes()
        {
            var codes = await _repository.GetAllAsync();
            return Ok(codes);
        }

        // GET: api/SupplementaryCodes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SupplementaryCode>> GetSupplementaryCode(Guid id)
        {
            var supplementaryCode = await _repository.GetByIdAsync(id);

            if (supplementaryCode == null)
            {
                return NotFound();
            }

            return Ok(supplementaryCode);
        }

        // PUT: api/SupplementaryCodes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSupplementaryCode(Guid id, SupplementaryCode supplementaryCode)
        {
            if (id != supplementaryCode.SupplementaryCodeId)
            {
                return BadRequest();
            }

            try
            {
                await _repository.UpdateAsync(supplementaryCode);
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

        // POST: api/SupplementaryCodes
        [HttpPost]
        public async Task<ActionResult<SupplementaryCode>> PostSupplementaryCode(SupplementaryCode supplementaryCode)
        {
            var createdCode = await _repository.AddAsync(supplementaryCode);

            return CreatedAtAction(
                nameof(GetSupplementaryCode), 
                new { id = createdCode.SupplementaryCodeId }, 
                createdCode
            );
        }

        // DELETE: api/SupplementaryCodes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSupplementaryCode(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}