using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NatureOfCommoditiesController : ControllerBase
    {
        private readonly INatureOfCommodityRepository _repository;

        public NatureOfCommoditiesController(INatureOfCommodityRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NatureOfCommodityDto>>> GetNatureOfCommodities()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<NatureOfCommodityDto>> GetNatureOfCommodity(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutNatureOfCommodity(Guid id, NatureOfCommodityDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<NatureOfCommodityDto>> PostNatureOfCommodity(NatureOfCommodityDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetNatureOfCommodity), new { id = result.NatureId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNatureOfCommodity(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}