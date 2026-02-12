using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificateRequestStatusesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CertificateRequestStatusesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CertificateRequestStatuses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificateRequestStatus>>> GetStatuses()
        {
            return await _context.CertificateRequestStatuses.ToListAsync();
        }

        // GET: api/CertificateRequestStatuses/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<CertificateRequestStatus>> GetStatus(Guid id)
        {
            var status = await _context.CertificateRequestStatuses.FindAsync(id);

            if (status == null) return NotFound();

            return status;
        }

        // POST: api/CertificateRequestStatuses
        [HttpPost]
        public async Task<ActionResult<CertificateRequestStatus>> CreateStatus(CertificateRequestStatus status)
        {
            if (status.RequestStatusId == Guid.Empty)
            {
                status.RequestStatusId = Guid.NewGuid();
            }

            // Optional: Auto-set DateEffective if not provided
            status.DateEffective ??= DateTime.UtcNow;

            _context.CertificateRequestStatuses.Add(status);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (StatusExists(status.StatusCode))
                {
                    return Conflict("Status code already exists.");
                }
                throw;
            }

            return CreatedAtAction(nameof(GetStatus), new { id = status.RequestStatusId }, status);
        }

        // PUT: api/CertificateRequestStatuses/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateStatus(Guid id, CertificateRequestStatus status)
        {
            if (id != status.RequestStatusId) return BadRequest();

            _context.Entry(status).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IdExists(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/CertificateRequestStatuses/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteStatus(Guid id)
        {
            var status = await _context.CertificateRequestStatuses.FindAsync(id);
            if (status == null) return NotFound();

            _context.CertificateRequestStatuses.Remove(status);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IdExists(Guid id)
        {
            return _context.CertificateRequestStatuses.Any(e => e.RequestStatusId == id);
        }

        private bool StatusExists(string code)
        {
            return _context.CertificateRequestStatuses.Any(e => e.StatusCode == code);
        }
    }
}