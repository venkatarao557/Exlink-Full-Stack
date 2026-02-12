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
    public class USTerritoriesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public USTerritoriesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/USTerritories
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Usterritory>>> GetUsterritories()
        {
            return await _context.Usterritories.ToListAsync();
        }

        // GET: api/USTerritories/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Usterritory>> GetUsterritory(Guid id)
        {
            var usterritory = await _context.Usterritories.FindAsync(id);

            if (usterritory == null)
            {
                return NotFound();
            }

            return usterritory;
        }

        // PUT: api/USTerritories/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsterritory(Guid id, Usterritory usterritory)
        {
            if (id != usterritory.UsterritoryId)
            {
                return BadRequest();
            }

            _context.Entry(usterritory).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UsterritoryExists(id))
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

        // POST: api/USTerritories
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Usterritory>> PostUsterritory(Usterritory usterritory)
        {
            _context.Usterritories.Add(usterritory);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUsterritory", new { id = usterritory.UsterritoryId }, usterritory);
        }

        // DELETE: api/USTerritories/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsterritory(Guid id)
        {
            var usterritory = await _context.Usterritories.FindAsync(id);
            if (usterritory == null)
            {
                return NotFound();
            }

            _context.Usterritories.Remove(usterritory);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UsterritoryExists(Guid id)
        {
            return _context.Usterritories.Any(e => e.UsterritoryId == id);
        }
    }
}
