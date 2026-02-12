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
    public class EUCountriesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public EUCountriesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/EUCountries
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Eucountry>>> GetEucountries()
        {
            return await _context.Eucountries.ToListAsync();
        }

        // GET: api/EUCountries/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Eucountry>> GetEucountry(Guid id)
        {
            var eucountry = await _context.Eucountries.FindAsync(id);

            if (eucountry == null)
            {
                return NotFound();
            }

            return eucountry;
        }

        // PUT: api/EUCountries/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEucountry(Guid id, Eucountry eucountry)
        {
            if (id != eucountry.EucountryId)
            {
                return BadRequest();
            }

            _context.Entry(eucountry).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EucountryExists(id))
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

        // POST: api/EUCountries
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Eucountry>> PostEucountry(Eucountry eucountry)
        {
            _context.Eucountries.Add(eucountry);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetEucountry", new { id = eucountry.EucountryId }, eucountry);
        }

        // DELETE: api/EUCountries/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEucountry(Guid id)
        {
            var eucountry = await _context.Eucountries.FindAsync(id);
            if (eucountry == null)
            {
                return NotFound();
            }

            _context.Eucountries.Remove(eucountry);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool EucountryExists(Guid id)
        {
            return _context.Eucountries.Any(e => e.EucountryId == id);
        }
    }
}
