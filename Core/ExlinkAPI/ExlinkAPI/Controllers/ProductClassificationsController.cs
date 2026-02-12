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
    public class ProductClassificationsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public ProductClassificationsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/ProductClassifications
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductClassification>>> GetProductClassifications()
        {
            return await _context.ProductClassifications.ToListAsync();
        }

        // GET: api/ProductClassifications/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProductClassification>> GetProductClassification(Guid id)
        {
            var productClassification = await _context.ProductClassifications.FindAsync(id);

            if (productClassification == null)
            {
                return NotFound();
            }

            return productClassification;
        }

        // PUT: api/ProductClassifications/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductClassification(Guid id, ProductClassification productClassification)
        {
            if (id != productClassification.ProductClassificationId)
            {
                return BadRequest();
            }

            _context.Entry(productClassification).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductClassificationExists(id))
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

        // POST: api/ProductClassifications
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ProductClassification>> PostProductClassification(ProductClassification productClassification)
        {
            _context.ProductClassifications.Add(productClassification);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProductClassification", new { id = productClassification.ProductClassificationId }, productClassification);
        }

        // DELETE: api/ProductClassifications/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductClassification(Guid id)
        {
            var productClassification = await _context.ProductClassifications.FindAsync(id);
            if (productClassification == null)
            {
                return NotFound();
            }

            _context.ProductClassifications.Remove(productClassification);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductClassificationExists(Guid id)
        {
            return _context.ProductClassifications.Any(e => e.ProductClassificationId == id);
        }
    }
}
