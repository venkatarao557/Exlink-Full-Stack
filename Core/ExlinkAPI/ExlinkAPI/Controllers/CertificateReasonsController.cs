using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificateReasonsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CertificateReasonsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CertificateReasons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificateReason>>> GetReasons()
        {
            return await _context.CertificateReasons.ToListAsync();
        }

        // GET: api/CertificateReasons/{id}
        [HttpGet("{id:guid}")]
        public async Task<ActionResult<CertificateReason>> GetReasonById(Guid id)
        {
            var reason = await _context.CertificateReasons.FindAsync(id);
            if (reason == null) return NotFound();
            return reason;
        }

        // GET: api/CertificateReasons/code/{code}
        [HttpGet("code/{code:int}")]
        public async Task<ActionResult<CertificateReason>> GetReasonByCode(int code)
        {
            var reason = await _context.CertificateReasons
                .FirstOrDefaultAsync(r => r.ReasonCode == code);

            if (reason == null) return NotFound();
            return reason;
        }

        // POST: api/CertificateReasons
        [HttpPost]
        public async Task<ActionResult<CertificateReason>> CreateReason(CertificateReason reason)
        {
            if (reason.ReasonId == Guid.Empty)
            {
                reason.ReasonId = Guid.NewGuid();
            }

            _context.CertificateReasons.Add(reason);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (_context.CertificateReasons.Any(r => r.ReasonCode == reason.ReasonCode))
                {
                    return Conflict("Reason code already exists.");
                }
                throw;
            }

            return CreatedAtAction(nameof(GetReasonById), new { id = reason.ReasonId }, reason);
        }

        // PUT: api/CertificateReasons/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateReason(Guid id, CertificateReason reason)
        {
            if (id != reason.ReasonId) return BadRequest();

            _context.Entry(reason).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ReasonExists(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/CertificateReasons/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReason(Guid id)
        {
            var reason = await _context.CertificateReasons.FindAsync(id);
            if (reason == null) return NotFound();

            _context.CertificateReasons.Remove(reason);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ReasonExists(Guid id)
        {
            return _context.CertificateReasons.Any(e => e.ReasonId == id);
        }
    }
}