using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommoditiesController : ControllerBase
    {
        private readonly ICommodityRepository _repository;

        public CommoditiesController(ICommodityRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CommodityDto>>> GetCommodities()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CommodityDto>> GetCommodity(Guid id)
        {
            var commodity = await _repository.GetByIdAsync(id);
            if (commodity == null) return NotFound();
            return Ok(commodity);
        }

        [HttpPost]
        public async Task<ActionResult<CommodityDto>> CreateCommodity(CommodityDto commodityDto)
        {
            if (await _repository.CodeExistsAsync(commodityDto.CommodityCode))
            {
                return Conflict("Commodity code already exists.");
            }

            var result = await _repository.CreateAsync(commodityDto);
            return CreatedAtAction(nameof(GetCommodity), new { id = result.CommodityId }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCommodity(Guid id, CommodityDto commodityDto)
        {
            if (id != commodityDto.CommodityId) return BadRequest();

            var success = await _repository.UpdateAsync(id, commodityDto);
            if (!success) return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCommodity(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();

            return NoContent();
        }
    }
}