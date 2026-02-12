using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ApprovedCertifiersController : ControllerBase
    {
        private readonly ExdocContext _context;

        public ApprovedCertifiersController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/ApprovedCertifiers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ApprovedCertifier>>> GetCertifiers()
        {
            return await _context.ApprovedCertifiers.ToListAsync();
        }

        // GET: api/ApprovedCertifiers/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<ApprovedCertifier>> GetCertifier(Guid id)
        {
            var certifier = await _context.ApprovedCertifiers.FindAsync(id);
            if (certifier == null) return NotFound();
            return certifier;
        }

        // POST: api/ApprovedCertifiers
        [HttpPost]
        public async Task<ActionResult<ApprovedCertifier>> CreateCertifier(ApprovedCertifier certifier)
        {
            certifier.CertifierId = Guid.NewGuid(); // Ensure new ID
            _context.ApprovedCertifiers.Add(certifier);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCertifier), new { id = certifier.CertifierId }, certifier);
        }

        // PUT: api/ApprovedCertifiers/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCertifier(Guid id, ApprovedCertifier certifier)
        {
            if (id != certifier.CertifierId) return BadRequest();

            _context.Entry(certifier).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.ApprovedCertifiers.Any(e => e.CertifierId == id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/ApprovedCertifiers/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCertifier(Guid id)
        {
            var certifier = await _context.ApprovedCertifiers.FindAsync(id);
            if (certifier == null) return NotFound();

            _context.ApprovedCertifiers.Remove(certifier);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}