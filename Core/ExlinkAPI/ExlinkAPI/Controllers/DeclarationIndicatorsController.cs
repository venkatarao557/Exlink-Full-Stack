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
    public class DeclarationIndicatorsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public DeclarationIndicatorsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/DeclarationIndicators
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DeclarationIndicator>>> GetDeclarationIndicators()
        {
            return await _context.DeclarationIndicators.ToListAsync();
        }

        // GET: api/DeclarationIndicators/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DeclarationIndicator>> GetDeclarationIndicator(Guid id)
        {
            var declarationIndicator = await _context.DeclarationIndicators.FindAsync(id);

            if (declarationIndicator == null)
            {
                return NotFound();
            }

            return declarationIndicator;
        }

        // PUT: api/DeclarationIndicators/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDeclarationIndicator(Guid id, DeclarationIndicator declarationIndicator)
        {
            if (id != declarationIndicator.DeclarationId)
            {
                return BadRequest();
            }

            _context.Entry(declarationIndicator).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DeclarationIndicatorExists(id))
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

        // POST: api/DeclarationIndicators
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<DeclarationIndicator>> PostDeclarationIndicator(DeclarationIndicator declarationIndicator)
        {
            _context.DeclarationIndicators.Add(declarationIndicator);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDeclarationIndicator", new { id = declarationIndicator.DeclarationId }, declarationIndicator);
        }

        // DELETE: api/DeclarationIndicators/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDeclarationIndicator(Guid id)
        {
            var declarationIndicator = await _context.DeclarationIndicators.FindAsync(id);
            if (declarationIndicator == null)
            {
                return NotFound();
            }

            _context.DeclarationIndicators.Remove(declarationIndicator);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool DeclarationIndicatorExists(Guid id)
        {
            return _context.DeclarationIndicators.Any(e => e.DeclarationId == id);
        }
    }
}
