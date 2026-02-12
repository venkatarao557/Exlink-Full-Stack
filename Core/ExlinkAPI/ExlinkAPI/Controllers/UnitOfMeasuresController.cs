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
    public class UnitOfMeasuresController : ControllerBase
    {
        private readonly ExdocContext _context;

        public UnitOfMeasuresController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/UnitOfMeasures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<UnitOfMeasure>>> GetUnitOfMeasures()
        {
            return await _context.UnitOfMeasures.ToListAsync();
        }

        // GET: api/UnitOfMeasures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<UnitOfMeasure>> GetUnitOfMeasure(Guid id)
        {
            var unitOfMeasure = await _context.UnitOfMeasures.FindAsync(id);

            if (unitOfMeasure == null)
            {
                return NotFound();
            }

            return unitOfMeasure;
        }

        // PUT: api/UnitOfMeasures/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUnitOfMeasure(Guid id, UnitOfMeasure unitOfMeasure)
        {
            if (id != unitOfMeasure.Uomid)
            {
                return BadRequest();
            }

            _context.Entry(unitOfMeasure).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UnitOfMeasureExists(id))
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

        // POST: api/UnitOfMeasures
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<UnitOfMeasure>> PostUnitOfMeasure(UnitOfMeasure unitOfMeasure)
        {
            _context.UnitOfMeasures.Add(unitOfMeasure);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUnitOfMeasure", new { id = unitOfMeasure.Uomid }, unitOfMeasure);
        }

        // DELETE: api/UnitOfMeasures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUnitOfMeasure(Guid id)
        {
            var unitOfMeasure = await _context.UnitOfMeasures.FindAsync(id);
            if (unitOfMeasure == null)
            {
                return NotFound();
            }

            _context.UnitOfMeasures.Remove(unitOfMeasure);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UnitOfMeasureExists(Guid id)
        {
            return _context.UnitOfMeasures.Any(e => e.Uomid == id);
        }
    }
}
