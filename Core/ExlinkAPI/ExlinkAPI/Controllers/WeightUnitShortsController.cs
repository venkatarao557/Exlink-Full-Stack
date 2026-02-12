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
    public class WeightUnitShortsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public WeightUnitShortsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/WeightUnitShorts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeightUnitShort>>> GetWeightUnitShorts()
        {
            return await _context.WeightUnitShorts.ToListAsync();
        }

        // GET: api/WeightUnitShorts/5
        [HttpGet("{id}")]
        public async Task<ActionResult<WeightUnitShort>> GetWeightUnitShort(Guid id)
        {
            var weightUnitShort = await _context.WeightUnitShorts.FindAsync(id);

            if (weightUnitShort == null)
            {
                return NotFound();
            }

            return weightUnitShort;
        }

        // PUT: api/WeightUnitShorts/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutWeightUnitShort(Guid id, WeightUnitShort weightUnitShort)
        {
            if (id != weightUnitShort.WeightUnitShortId)
            {
                return BadRequest();
            }

            _context.Entry(weightUnitShort).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WeightUnitShortExists(id))
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

        // POST: api/WeightUnitShorts
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<WeightUnitShort>> PostWeightUnitShort(WeightUnitShort weightUnitShort)
        {
            _context.WeightUnitShorts.Add(weightUnitShort);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetWeightUnitShort", new { id = weightUnitShort.WeightUnitShortId }, weightUnitShort);
        }

        // DELETE: api/WeightUnitShorts/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWeightUnitShort(Guid id)
        {
            var weightUnitShort = await _context.WeightUnitShorts.FindAsync(id);
            if (weightUnitShort == null)
            {
                return NotFound();
            }

            _context.WeightUnitShorts.Remove(weightUnitShort);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool WeightUnitShortExists(Guid id)
        {
            return _context.WeightUnitShorts.Any(e => e.WeightUnitShortId == id);
        }
    }
}
