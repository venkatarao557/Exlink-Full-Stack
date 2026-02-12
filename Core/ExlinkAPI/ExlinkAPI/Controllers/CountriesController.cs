using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountriesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CountriesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/Countries
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Country>>> GetCountries()
        {
            return await _context.Countries.OrderBy(c => c.CountryName).ToListAsync();
        }

        // GET: api/Countries/{id}
        [HttpGet("{id:guid}")]
        public async Task<ActionResult<Country>> GetCountry(Guid id)
        {
            var country = await _context.Countries.FindAsync(id);

            if (country == null) return NotFound();

            return country;
        }

        // GET: api/Countries/code/{code}
        [HttpGet("code/{code}")]
        public async Task<ActionResult<Country>> GetCountryByCode(string code)
        {
            var country = await _context.Countries
                .FirstOrDefaultAsync(c => c.CountryCode == code);

            if (country == null) return NotFound();

            return country;
        }

        // POST: api/Countries
        [HttpPost]
        public async Task<ActionResult<Country>> CreateCountry(Country country)
        {
            if (country.CountryId == Guid.Empty)
            {
                country.CountryId = Guid.NewGuid();
            }

            _context.Countries.Add(country);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CountryExists(country.CountryCode))
                {
                    return Conflict("Country code already exists.");
                }
                throw;
            }

            return CreatedAtAction(nameof(GetCountry), new { id = country.CountryId }, country);
        }

        // PUT: api/Countries/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCountry(Guid id, Country country)
        {
            if (id != country.CountryId) return BadRequest();

            _context.Entry(country).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IdExists(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/Countries/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCountry(Guid id)
        {
            var country = await _context.Countries.FindAsync(id);
            if (country == null) return NotFound();

            _context.Countries.Remove(country);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IdExists(Guid id)
        {
            return _context.Countries.Any(e => e.CountryId == id);
        }

        private bool CountryExists(string code)
        {
            return _context.Countries.Any(e => e.CountryCode == code);
        }
    }
}