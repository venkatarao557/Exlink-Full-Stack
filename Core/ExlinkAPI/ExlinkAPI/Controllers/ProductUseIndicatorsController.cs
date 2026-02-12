using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductUseIndicatorsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public ProductUseIndicatorsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/ProductUseIndicators
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductUseIndicator>>> GetProductUseIndicators()
        {
            return await _context.ProductUseIndicators.ToListAsync();
        }

        // GET: api/ProductUseIndicators/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProductUseIndicator>> GetProductUseIndicator(Guid id)
        {
            var productUseIndicator = await _context.ProductUseIndicators.FindAsync(id);

            if (productUseIndicator == null)
            {
                return NotFound();
            }

            return productUseIndicator;
        }

        // PUT: api/ProductUseIndicators/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductUseIndicator(Guid id, ProductUseIndicator productUseIndicator)
        {
            if (id != productUseIndicator.ProductUseId)
            {
                return BadRequest();
            }

            _context.Entry(productUseIndicator).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductUseIndicatorExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ProductUseIndicators
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ProductUseIndicator>> PostProductUseIndicator(ProductUseIndicator productUseIndicator)
        {
            _context.ProductUseIndicators.Add(productUseIndicator);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProductUseIndicator", new { id = productUseIndicator.ProductUseId }, productUseIndicator);
        }

        // DELETE: api/ProductUseIndicators/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductUseIndicator(Guid id)
        {
            var productUseIndicator = await _context.ProductUseIndicators.FindAsync(id);
            if (productUseIndicator == null)
            {
                return NotFound();
            }

            _context.ProductUseIndicators.Remove(productUseIndicator);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductUseIndicatorExists(Guid id)
        {
            return _context.ProductUseIndicators.Any(e => e.ProductUseId == id);
        }
    }
}
