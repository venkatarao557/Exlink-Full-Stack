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
    public class PreservationTypesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public PreservationTypesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/PreservationTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PreservationType>>> GetPreservationTypes()
        {
            return await _context.PreservationTypes.ToListAsync();
        }

        // GET: api/PreservationTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PreservationType>> GetPreservationType(Guid id)
        {
            var preservationType = await _context.PreservationTypes.FindAsync(id);

            if (preservationType == null)
            {
                return NotFound();
            }

            return preservationType;
        }

        // PUT: api/PreservationTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPreservationType(Guid id, PreservationType preservationType)
        {
            if (id != preservationType.PreservationTypeId)
            {
                return BadRequest();
            }

            _context.Entry(preservationType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PreservationTypeExists(id))
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

        // POST: api/PreservationTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PreservationType>> PostPreservationType(PreservationType preservationType)
        {
            _context.PreservationTypes.Add(preservationType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPreservationType", new { id = preservationType.PreservationTypeId }, preservationType);
        }

        // DELETE: api/PreservationTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePreservationType(Guid id)
        {
            var preservationType = await _context.PreservationTypes.FindAsync(id);
            if (preservationType == null)
            {
                return NotFound();
            }

            _context.PreservationTypes.Remove(preservationType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PreservationTypeExists(Guid id)
        {
            return _context.PreservationTypes.Any(e => e.PreservationTypeId == id);
        }
    }
}
