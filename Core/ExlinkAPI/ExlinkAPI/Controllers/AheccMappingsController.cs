using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AheccMappingsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public AheccMappingsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/AheccMappings
        // Fetches all mappings, including the related CutType data
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AheccproductMapping>>> GetMappings()
        {
            return await _context.AheccproductMappings
                .Include(m => m.CutCodeNavigation)
                .ToListAsync();
        }

        // GET: api/AheccMappings/search?ahecc=123
        // Since there is no Primary Key, we search by the indexed Ahecc code
        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<AheccproductMapping>>> GetByAhecc([FromQuery] string ahecc)
        {
            var results = await _context.AheccproductMappings
                .Where(m => m.Ahecc == ahecc)
                .Include(m => m.CutCodeNavigation)
                .ToListAsync();

            if (!results.Any()) return NotFound();
            return results;
        }

        // POST: api/AheccMappings
        // You can still Insert into keyless tables
        [HttpPost]
        public async Task<ActionResult<AheccproductMapping>> CreateMapping(AheccproductMapping mapping)
        {
            if (mapping.MappingId == Guid.Empty)
            {
                mapping.MappingId = Guid.NewGuid();
            }

            _context.AheccproductMappings.Add(mapping);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetByAhecc), new { ahecc = mapping.Ahecc }, mapping);
        }
    }
}