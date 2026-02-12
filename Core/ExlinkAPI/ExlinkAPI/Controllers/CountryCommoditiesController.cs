using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountryCommoditiesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CountryCommoditiesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CountryCommodities
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CountryCommodity>>> GetCountryCommodities()
        {
            return await _context.CountryCommodities.ToListAsync(); //
        }

        // GET: api/CountryCommodities/code/{countryCode}
        [HttpGet("code/{countryCode}")]
        public async Task<ActionResult<CountryCommodity>> GetByCountryCode(string countryCode)
        {
            var mapping = await _context.CountryCommodities
                .FirstOrDefaultAsync(c => c.CountryCode == countryCode); //

            if (mapping == null) return NotFound();

            return mapping;
        }

        // POST: api/CountryCommodities
        [HttpPost]
        public async Task<ActionResult<CountryCommodity>> CreateMapping(CountryCommodity mapping)
        {
            if (mapping.CountryCommodityId == Guid.Empty)
            {
                mapping.CountryCommodityId = Guid.NewGuid(); //
            }

            _context.CountryCommodities.Add(mapping); //

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (_context.CountryCommodities.Any(c => c.CountryCode == mapping.CountryCode))
                {
                    return Conflict("A mapping for this country code already exists."); //
                }
                throw;
            }

            return CreatedAtAction(nameof(GetByCountryCode), new { countryCode = mapping.CountryCode }, mapping);
        }

        // PUT: api/CountryCommodities/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateMapping(Guid id, CountryCommodity mapping)
        {
            if (id != mapping.CountryCommodityId) return BadRequest(); //

            _context.Entry(mapping).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.CountryCommodities.Any(e => e.CountryCommodityId == id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/CountryCommodities/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMapping(Guid id)
        {
            var mapping = await _context.CountryCommodities.FindAsync(id);
            if (mapping == null) return NotFound();

            _context.CountryCommodities.Remove(mapping);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}