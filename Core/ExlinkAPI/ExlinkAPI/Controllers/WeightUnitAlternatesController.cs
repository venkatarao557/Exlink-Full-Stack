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
    public class WeightUnitAlternatesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public WeightUnitAlternatesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/WeightUnitAlternates
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeightUnitAlternate>>> GetWeightUnitAlternates()
        {
            return await _context.WeightUnitAlternates.ToListAsync();
        }

        // GET: api/WeightUnitAlternates/5
        [HttpGet("{id}")]
        public async Task<ActionResult<WeightUnitAlternate>> GetWeightUnitAlternate(Guid id)
        {
            var weightUnitAlternate = await _context.WeightUnitAlternates.FindAsync(id);

            if (weightUnitAlternate == null)
            {
                return NotFound();
            }

            return weightUnitAlternate;
        }

        // PUT: api/WeightUnitAlternates/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutWeightUnitAlternate(Guid id, WeightUnitAlternate weightUnitAlternate)
        {
            if (id != weightUnitAlternate.WeightUnitAltId)
            {
                return BadRequest();
            }

            _context.Entry(weightUnitAlternate).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WeightUnitAlternateExists(id))
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

        // POST: api/WeightUnitAlternates
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<WeightUnitAlternate>> PostWeightUnitAlternate(WeightUnitAlternate weightUnitAlternate)
        {
            _context.WeightUnitAlternates.Add(weightUnitAlternate);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetWeightUnitAlternate", new { id = weightUnitAlternate.WeightUnitAltId }, weightUnitAlternate);
        }

        // DELETE: api/WeightUnitAlternates/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteWeightUnitAlternate(Guid id)
        {
            var weightUnitAlternate = await _context.WeightUnitAlternates.FindAsync(id);
            if (weightUnitAlternate == null)
            {
                return NotFound();
            }

            _context.WeightUnitAlternates.Remove(weightUnitAlternate);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool WeightUnitAlternateExists(Guid id)
        {
            return _context.WeightUnitAlternates.Any(e => e.WeightUnitAltId == id);
        }
    }
}
