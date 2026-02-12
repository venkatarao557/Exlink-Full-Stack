using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ExlinkAPI.Models;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CertificatePrintIndicatorsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CertificatePrintIndicatorsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CertificatePrintIndicators
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CertificatePrintIndicator>>> GetIndicators()
        {
            return await _context.CertificatePrintIndicators.ToListAsync();
        }

        // GET: api/CertificatePrintIndicators/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<CertificatePrintIndicator>> GetIndicator(Guid id)
        {
            var indicator = await _context.CertificatePrintIndicators.FindAsync(id);

            if (indicator == null) return NotFound();

            return indicator;
        }

        // POST: api/CertificatePrintIndicators
        [HttpPost]
        public async Task<ActionResult<CertificatePrintIndicator>> CreateIndicator(CertificatePrintIndicator indicator)
        {
            // Ensure a new ID is generated if not provided
            if (indicator.PrintIndicatorId == Guid.Empty)
            {
                indicator.PrintIndicatorId = Guid.NewGuid();
            }

            _context.CertificatePrintIndicators.Add(indicator);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetIndicator), new { id = indicator.PrintIndicatorId }, indicator);
        }

        // PUT: api/CertificatePrintIndicators/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateIndicator(Guid id, CertificatePrintIndicator indicator)
        {
            if (id != indicator.PrintIndicatorId) return BadRequest();

            _context.Entry(indicator).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IndicatorExists(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        // DELETE: api/CertificatePrintIndicators/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIndicator(Guid id)
        {
            var indicator = await _context.CertificatePrintIndicators.FindAsync(id);
            if (indicator == null) return NotFound();

            _context.CertificatePrintIndicators.Remove(indicator);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IndicatorExists(Guid id)
        {
            return _context.CertificatePrintIndicators.Any(e => e.PrintIndicatorId == id);
        }
    }
}