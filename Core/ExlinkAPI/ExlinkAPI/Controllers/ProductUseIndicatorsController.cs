using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductUseIndicatorsController : ControllerBase
    {
        private readonly IProductUseIndicatorRepository _repository;

        public ProductUseIndicatorsController(IProductUseIndicatorRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductUseIndicatorDto>>> GetProductUseIndicators()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ProductUseIndicatorDto>> GetProductUseIndicator(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductUseIndicator(Guid id, ProductUseIndicatorDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<ProductUseIndicatorDto>> PostProductUseIndicator(ProductUseIndicatorDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetProductUseIndicator), new { id = result.ProductUseId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductUseIndicator(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}