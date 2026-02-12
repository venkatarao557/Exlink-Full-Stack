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
    public class QualityQualifiersController : ControllerBase
    {
        private readonly ExdocContext _context;

        public QualityQualifiersController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/QualityQualifiers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QualityQualifier>>> GetQualityQualifiers()
        {
            return await _context.QualityQualifiers.ToListAsync();
        }

        // GET: api/QualityQualifiers/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QualityQualifier>> GetQualityQualifier(Guid id)
        {
            var qualityQualifier = await _context.QualityQualifiers.FindAsync(id);

            if (qualityQualifier == null)
            {
                return NotFound();
            }

            return qualityQualifier;
        }

        // PUT: api/QualityQualifiers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQualityQualifier(Guid id, QualityQualifier qualityQualifier)
        {
            if (id != qualityQualifier.QualityQualifierId)
            {
                return BadRequest();
            }

            _context.Entry(qualityQualifier).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QualityQualifierExists(id))
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

        // POST: api/QualityQualifiers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<QualityQualifier>> PostQualityQualifier(QualityQualifier qualityQualifier)
        {
            _context.QualityQualifiers.Add(qualityQualifier);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQualityQualifier", new { id = qualityQualifier.QualityQualifierId }, qualityQualifier);
        }

        // DELETE: api/QualityQualifiers/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQualityQualifier(Guid id)
        {
            var qualityQualifier = await _context.QualityQualifiers.FindAsync(id);
            if (qualityQualifier == null)
            {
                return NotFound();
            }

            _context.QualityQualifiers.Remove(qualityQualifier);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool QualityQualifierExists(Guid id)
        {
            return _context.QualityQualifiers.Any(e => e.QualityQualifierId == id);
        }
    }
}
