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
    public class DominantProductsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public DominantProductsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/DominantProducts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DominantProduct>>> GetDominantProducts()
        {
            return await _context.DominantProducts.ToListAsync();
        }

        // GET: api/DominantProducts/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DominantProduct>> GetDominantProduct(Guid id)
        {
            var dominantProduct = await _context.DominantProducts.FindAsync(id);

            if (dominantProduct == null)
            {
                return NotFound();
            }

            return dominantProduct;
        }

        // PUT: api/DominantProducts/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDominantProduct(Guid id, DominantProduct dominantProduct)
        {
            if (id != dominantProduct.DominantProductId)
            {
                return BadRequest();
            }

            _context.Entry(dominantProduct).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DominantProductExists(id))
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

        // POST: api/DominantProducts
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<DominantProduct>> PostDominantProduct(DominantProduct dominantProduct)
        {
            _context.DominantProducts.Add(dominantProduct);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDominantProduct", new { id = dominantProduct.DominantProductId }, dominantProduct);
        }

        // DELETE: api/DominantProducts/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDominantProduct(Guid id)
        {
            var dominantProduct = await _context.DominantProducts.FindAsync(id);
            if (dominantProduct == null)
            {
                return NotFound();
            }

            _context.DominantProducts.Remove(dominantProduct);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool DominantProductExists(Guid id)
        {
            return _context.DominantProducts.Any(e => e.DominantProductId == id);
        }
    }
}
