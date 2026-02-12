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
    public class LocationQualifiersController : ControllerBase
    {
        private readonly ExdocContext _context;

        public LocationQualifiersController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/LocationQualifiers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<LocationQualifier>>> GetLocationQualifiers()
        {
            return await _context.LocationQualifiers.ToListAsync();
        }

        // GET: api/LocationQualifiers/5
        [HttpGet("{id}")]
        public async Task<ActionResult<LocationQualifier>> GetLocationQualifier(Guid id)
        {
            var locationQualifier = await _context.LocationQualifiers.FindAsync(id);

            if (locationQualifier == null)
            {
                return NotFound();
            }

            return locationQualifier;
        }

        // PUT: api/LocationQualifiers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutLocationQualifier(Guid id, LocationQualifier locationQualifier)
        {
            if (id != locationQualifier.LocationQualId)
            {
                return BadRequest();
            }

            _context.Entry(locationQualifier).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LocationQualifierExists(id))
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

        // POST: api/LocationQualifiers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<LocationQualifier>> PostLocationQualifier(LocationQualifier locationQualifier)
        {
            _context.LocationQualifiers.Add(locationQualifier);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetLocationQualifier", new { id = locationQualifier.LocationQualId }, locationQualifier);
        }

        // DELETE: api/LocationQualifiers/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLocationQualifier(Guid id)
        {
            var locationQualifier = await _context.LocationQualifiers.FindAsync(id);
            if (locationQualifier == null)
            {
                return NotFound();
            }

            _context.LocationQualifiers.Remove(locationQualifier);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool LocationQualifierExists(Guid id)
        {
            return _context.LocationQualifiers.Any(e => e.LocationQualId == id);
        }
    }
}
