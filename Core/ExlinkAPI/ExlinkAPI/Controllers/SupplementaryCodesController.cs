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
    public class SupplementaryCodesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public SupplementaryCodesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/SupplementaryCodes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SupplementaryCode>>> GetSupplementaryCodes()
        {
            return await _context.SupplementaryCodes.ToListAsync();
        }

        // GET: api/SupplementaryCodes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<SupplementaryCode>> GetSupplementaryCode(Guid id)
        {
            var supplementaryCode = await _context.SupplementaryCodes.FindAsync(id);

            if (supplementaryCode == null)
            {
                return NotFound();
            }

            return supplementaryCode;
        }

        // PUT: api/SupplementaryCodes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSupplementaryCode(Guid id, SupplementaryCode supplementaryCode)
        {
            if (id != supplementaryCode.SupplementaryCodeId)
            {
                return BadRequest();
            }

            _context.Entry(supplementaryCode).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SupplementaryCodeExists(id))
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

        // POST: api/SupplementaryCodes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<SupplementaryCode>> PostSupplementaryCode(SupplementaryCode supplementaryCode)
        {
            _context.SupplementaryCodes.Add(supplementaryCode);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSupplementaryCode", new { id = supplementaryCode.SupplementaryCodeId }, supplementaryCode);
        }

        // DELETE: api/SupplementaryCodes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSupplementaryCode(Guid id)
        {
            var supplementaryCode = await _context.SupplementaryCodes.FindAsync(id);
            if (supplementaryCode == null)
            {
                return NotFound();
            }

            _context.SupplementaryCodes.Remove(supplementaryCode);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SupplementaryCodeExists(Guid id)
        {
            return _context.SupplementaryCodes.Any(e => e.SupplementaryCodeId == id);
        }
    }
}
