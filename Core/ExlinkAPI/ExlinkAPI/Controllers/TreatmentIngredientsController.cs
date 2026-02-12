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
    public class TreatmentIngredientsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public TreatmentIngredientsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/TreatmentIngredients
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TreatmentIngredient>>> GetTreatmentIngredients()
        {
            return await _context.TreatmentIngredients.ToListAsync();
        }

        // GET: api/TreatmentIngredients/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TreatmentIngredient>> GetTreatmentIngredient(Guid id)
        {
            var treatmentIngredient = await _context.TreatmentIngredients.FindAsync(id);

            if (treatmentIngredient == null)
            {
                return NotFound();
            }

            return treatmentIngredient;
        }

        // PUT: api/TreatmentIngredients/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTreatmentIngredient(Guid id, TreatmentIngredient treatmentIngredient)
        {
            if (id != treatmentIngredient.IngredientId)
            {
                return BadRequest();
            }

            _context.Entry(treatmentIngredient).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TreatmentIngredientExists(id))
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

        // POST: api/TreatmentIngredients
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<TreatmentIngredient>> PostTreatmentIngredient(TreatmentIngredient treatmentIngredient)
        {
            _context.TreatmentIngredients.Add(treatmentIngredient);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTreatmentIngredient", new { id = treatmentIngredient.IngredientId }, treatmentIngredient);
        }

        // DELETE: api/TreatmentIngredients/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTreatmentIngredient(Guid id)
        {
            var treatmentIngredient = await _context.TreatmentIngredients.FindAsync(id);
            if (treatmentIngredient == null)
            {
                return NotFound();
            }

            _context.TreatmentIngredients.Remove(treatmentIngredient);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TreatmentIngredientExists(Guid id)
        {
            return _context.TreatmentIngredients.Any(e => e.IngredientId == id);
        }
    }
}
