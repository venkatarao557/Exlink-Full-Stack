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
    public class TreatmentConcentrationsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public TreatmentConcentrationsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/TreatmentConcentrations
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentConcentration>>> GetTreatmentConcentrations()
        {
            return await _context.TreatmentConcentrations.ToListAsync();
        }

        // GET: api/TreatmentConcentrations/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentConcentration>> GetTreatmentConcentration(Guid id)
        {
            var treatmentConcentration = await _context.TreatmentConcentrations.FindAsync(id);

            if (treatmentConcentration == null)
            {
                return NotFound();
            }

            return treatmentConcentration;
        }

        // PUT: api/TreatmentConcentrations/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatmentConcentration(Guid id, TreatmentConcentration treatmentConcentration)
        {
            if (id != treatmentConcentration.ConcentrationUnitId)
            {
                return BadRequest();
            }

            _context.Entry(treatmentConcentration).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TreatmentConcentrationExists(id))
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

        // POST: api/TreatmentConcentrations
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<TreatmentConcentration>> PostTreatmentConcentration(TreatmentConcentration treatmentConcentration)
        {
            _context.TreatmentConcentrations.Add(treatmentConcentration);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTreatmentConcentration", new { id = treatmentConcentration.ConcentrationUnitId }, treatmentConcentration);
        }

        // DELETE: api/TreatmentConcentrations/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatmentConcentration(Guid id)
        {
            var treatmentConcentration = await _context.TreatmentConcentrations.FindAsync(id);
            if (treatmentConcentration == null)
            {
                return NotFound();
            }

            _context.TreatmentConcentrations.Remove(treatmentConcentration);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TreatmentConcentrationExists(Guid id)
        {
            return _context.TreatmentConcentrations.Any(e => e.ConcentrationUnitId == id);
        }
    }
}
