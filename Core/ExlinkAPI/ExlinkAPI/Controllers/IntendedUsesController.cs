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
    public class IntendedUsesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public IntendedUsesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/IntendedUses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IntendedUse>>> GetIntendedUses()
        {
            return await _context.IntendedUses.ToListAsync();
        }

        // GET: api/IntendedUses/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IntendedUse>> GetIntendedUse(Guid id)
        {
            var intendedUse = await _context.IntendedUses.FindAsync(id);

            if (intendedUse == null)
            {
                return NotFound();
            }

            return intendedUse;
        }

        // PUT: api/IntendedUses/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIntendedUse(Guid id, IntendedUse intendedUse)
        {
            if (id != intendedUse.IntendedUseId)
            {
                return BadRequest();
            }

            _context.Entry(intendedUse).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IntendedUseExists(id))
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

        // POST: api/IntendedUses
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<IntendedUse>> PostIntendedUse(IntendedUse intendedUse)
        {
            _context.IntendedUses.Add(intendedUse);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetIntendedUse", new { id = intendedUse.IntendedUseId }, intendedUse);
        }

        // DELETE: api/IntendedUses/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIntendedUse(Guid id)
        {
            var intendedUse = await _context.IntendedUses.FindAsync(id);
            if (intendedUse == null)
            {
                return NotFound();
            }

            _context.IntendedUses.Remove(intendedUse);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IntendedUseExists(Guid id)
        {
            return _context.IntendedUses.Any(e => e.IntendedUseId == id);
        }
    }
}
