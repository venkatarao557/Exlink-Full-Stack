using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProcessTypesController : ControllerBase
    {
        private readonly IProcessTypeRepository _repository;

        public ProcessTypesController(IProcessTypeRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProcessTypeDto>>> GetProcessTypes()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ProcessTypeDto>> GetProcessType(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProcessType(Guid id, ProcessTypeDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<ProcessTypeDto>> PostProcessType(ProcessTypeDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetProcessType), new { id = result.ProcessTypeId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProcessType(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}