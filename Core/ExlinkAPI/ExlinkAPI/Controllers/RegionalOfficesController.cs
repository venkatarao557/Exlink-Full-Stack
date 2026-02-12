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
    public class RegionalOfficesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public RegionalOfficesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/RegionalOffices
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RegionalOffice>>> GetRegionalOffices()
        {
            return await _context.RegionalOffices.ToListAsync();
        }

        // GET: api/RegionalOffices/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RegionalOffice>> GetRegionalOffice(Guid id)
        {
            var regionalOffice = await _context.RegionalOffices.FindAsync(id);

            if (regionalOffice == null)
            {
                return NotFound();
            }

            return regionalOffice;
        }

        // PUT: api/RegionalOffices/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRegionalOffice(Guid id, RegionalOffice regionalOffice)
        {
            if (id != regionalOffice.OfficeId)
            {
                return BadRequest();
            }

            _context.Entry(regionalOffice).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RegionalOfficeExists(id))
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

        // POST: api/RegionalOffices
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<RegionalOffice>> PostRegionalOffice(RegionalOffice regionalOffice)
        {
            _context.RegionalOffices.Add(regionalOffice);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRegionalOffice", new { id = regionalOffice.OfficeId }, regionalOffice);
        }

        // DELETE: api/RegionalOffices/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRegionalOffice(Guid id)
        {
            var regionalOffice = await _context.RegionalOffices.FindAsync(id);
            if (regionalOffice == null)
            {
                return NotFound();
            }

            _context.RegionalOffices.Remove(regionalOffice);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RegionalOfficeExists(Guid id)
        {
            return _context.RegionalOffices.Any(e => e.OfficeId == id);
        }
    }
}
