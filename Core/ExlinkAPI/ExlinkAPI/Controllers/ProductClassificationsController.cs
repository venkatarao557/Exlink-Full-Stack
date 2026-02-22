using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductClassificationsController : ControllerBase
    {
        private readonly IProductClassificationRepository _repository;

        public ProductClassificationsController(IProductClassificationRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductClassificationDto>>> GetProductClassifications()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ProductClassificationDto>> GetProductClassification(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductClassification(Guid id, ProductClassificationDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        [HttpPost]
        public async Task<ActionResult<ProductClassificationDto>> PostProductClassification(ProductClassificationDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetProductClassification), new { id = result.ProductClassificationId }, result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductClassification(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}