using ExlinkAPI.Models;
using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DominantProductsController : ControllerBase
    {
        private readonly IDominantProductRepository _repository;

        public DominantProductsController(IDominantProductRepository repository)
        {
            _repository = repository;
        }

        // GET: api/DominantProducts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DominantProductDto>>> GetDominantProducts()
        {
            var products = await _repository.GetAllAsync();
            var dtos = products.Select(p => MapToDto(p));
            return Ok(dtos);
        }

        // GET: api/DominantProducts/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<DominantProductDto>> GetDominantProduct(Guid id)
        {
            var product = await _repository.GetByIdAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(MapToDto(product));
        }

        // PUT: api/DominantProducts/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDominantProduct(Guid id, DominantProductDto dto)
        {
            if (id != dto.DominantProductId)
            {
                return BadRequest();
            }

            try
            {
                await _repository.UpdateAsync(MapToEntity(dto));
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

        // POST: api/DominantProducts
        [HttpPost]
        public async Task<ActionResult<DominantProductDto>> PostDominantProduct(DominantProductDto dto)
        {
            var product = MapToEntity(dto);
            await _repository.AddAsync(product);

            return CreatedAtAction("GetDominantProduct", new { id = product.DominantProductId }, MapToDto(product));
        }

        // DELETE: api/DominantProducts/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDominantProduct(Guid id)
        {
            if (!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }

            await _repository.DeleteAsync(id);
            return NoContent();
        }

        // Manual Mapping Helpers
        private static DominantProductDto MapToDto(DominantProduct p) => new()
        {
            DominantProductId = p.DominantProductId,
            ProductName = p.ProductName
        };

        private static DominantProduct MapToEntity(DominantProductDto d) => new()
        {
            DominantProductId = d.DominantProductId,
            ProductName = d.ProductName
        };
    }
}