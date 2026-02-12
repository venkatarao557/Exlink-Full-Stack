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
    public class RegulatoryDocumentsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public RegulatoryDocumentsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/RegulatoryDocuments
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RegulatoryDocument>>> GetRegulatoryDocuments()
        {
            return await _context.RegulatoryDocuments.ToListAsync();
        }

        // GET: api/RegulatoryDocuments/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RegulatoryDocument>> GetRegulatoryDocument(Guid id)
        {
            var regulatoryDocument = await _context.RegulatoryDocuments.FindAsync(id);

            if (regulatoryDocument == null)
            {
                return NotFound();
            }

            return regulatoryDocument;
        }

        // PUT: api/RegulatoryDocuments/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRegulatoryDocument(Guid id, RegulatoryDocument regulatoryDocument)
        {
            if (id != regulatoryDocument.RegulatoryDocId)
            {
                return BadRequest();
            }

            _context.Entry(regulatoryDocument).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RegulatoryDocumentExists(id))
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

        // POST: api/RegulatoryDocuments
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<RegulatoryDocument>> PostRegulatoryDocument(RegulatoryDocument regulatoryDocument)
        {
            _context.RegulatoryDocuments.Add(regulatoryDocument);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRegulatoryDocument", new { id = regulatoryDocument.RegulatoryDocId }, regulatoryDocument);
        }

        // DELETE: api/RegulatoryDocuments/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRegulatoryDocument(Guid id)
        {
            var regulatoryDocument = await _context.RegulatoryDocuments.FindAsync(id);
            if (regulatoryDocument == null)
            {
                return NotFound();
            }

            _context.RegulatoryDocuments.Remove(regulatoryDocument);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RegulatoryDocumentExists(Guid id)
        {
            return _context.RegulatoryDocuments.Any(e => e.RegulatoryDocId == id);
        }
    }
}
