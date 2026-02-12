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
    public class RfpstatusController : ControllerBase
    {
        private readonly ExdocContext _context;

        public RfpstatusController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/Rfpstatus
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Rfpstatus>>> GetRfpstatuses()
        {
            return await _context.Rfpstatuses.ToListAsync();
        }

        // GET: api/Rfpstatus/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Rfpstatus>> GetRfpstatus(Guid id)
        {
            var rfpstatus = await _context.Rfpstatuses.FindAsync(id);

            if (rfpstatus == null)
            {
                return NotFound();
            }

            return rfpstatus;
        }

        // PUT: api/Rfpstatus/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRfpstatus(Guid id, Rfpstatus rfpstatus)
        {
            if (id != rfpstatus.StatusId)
            {
                return BadRequest();
            }

            _context.Entry(rfpstatus).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RfpstatusExists(id))
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

        // POST: api/Rfpstatus
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Rfpstatus>> PostRfpstatus(Rfpstatus rfpstatus)
        {
            _context.Rfpstatuses.Add(rfpstatus);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRfpstatus", new { id = rfpstatus.StatusId }, rfpstatus);
        }

        // DELETE: api/Rfpstatus/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRfpstatus(Guid id)
        {
            var rfpstatus = await _context.Rfpstatuses.FindAsync(id);
            if (rfpstatus == null)
            {
                return NotFound();
            }

            _context.Rfpstatuses.Remove(rfpstatus);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RfpstatusExists(Guid id)
        {
            return _context.Rfpstatuses.Any(e => e.StatusId == id);
        }
    }
}
