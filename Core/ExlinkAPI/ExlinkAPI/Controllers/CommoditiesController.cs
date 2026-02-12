using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommoditiesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CommoditiesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/Commodities
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Commodity>>> GetCommodities()
        {
            // We usually don't include all Products/ProductTypes here to keep the list fast
            return await _context.Commodities.ToListAsync();
        }

        // GET: api/Commodities/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<Commodity>> GetCommodity(Guid id)
        {
            // Use .Include if you want to see the associated ProductTypes or Products
            var commodity = await _context.Commodities
                .Include(c => c.ProductTypes)
                .FirstOrDefaultAsync(c => c.CommodityId == id);

            if (commodity == null) return NotFound();

            return commodity;
        }

        // POST: api/Commodities
        [HttpPost]
        public async Task<ActionResult<Commodity>> CreateCommodity(Commodity commodity)
        {
            if (commodity.CommodityId == Guid.Empty)
            {
                commodity.CommodityId = Guid.NewGuid();
            }

            _context.Commodities.Add(commodity);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CommodityExists(commodity.CommodityCode))
                {
                    return Conflict("Commodity code already exists.");
                }
                throw;
            }

            return CreatedAtAction(nameof(GetCommodity), new { id = commodity.CommodityId }, commodity);
        }

        // PUT: api/Commodities/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCommodity(Guid id, Commodity commodity)
        {
            if (id != commodity.CommodityId) return BadRequest();

            _context.Entry(commodity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Commodities.Any(e => e.CommodityId == id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/Commodities/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCommodity(Guid id)
        {
            var commodity = await _context.Commodities.FindAsync(id);
            if (commodity == null) return NotFound();

            // Note: If there are related Products, this may fail depending on your 
            // SQL Foreign Key "On Delete" settings.
            _context.Commodities.Remove(commodity);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CommodityExists(string code)
        {
            return _context.Commodities.Any(e => e.CommodityCode == code);
        }
    }
}