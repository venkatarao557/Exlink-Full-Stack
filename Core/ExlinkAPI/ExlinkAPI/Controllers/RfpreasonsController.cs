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
    public class RfpreasonsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public RfpreasonsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/Rfpreasons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Rfpreason>>> GetRfpreasons()
        {
            return await _context.Rfpreasons.ToListAsync();
        }

        // GET: api/Rfpreasons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Rfpreason>> GetRfpreason(Guid id)
        {
            var rfpreason = await _context.Rfpreasons.FindAsync(id);

            if (rfpreason == null)
            {
                return NotFound();
            }

            return rfpreason;
        }

        // PUT: api/Rfpreasons/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRfpreason(Guid id, Rfpreason rfpreason)
        {
            if (id != rfpreason.ReasonId)
            {
                return BadRequest();
            }

            _context.Entry(rfpreason).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RfpreasonExists(id))
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

        // POST: api/Rfpreasons
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Rfpreason>> PostRfpreason(Rfpreason rfpreason)
        {
            _context.Rfpreasons.Add(rfpreason);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRfpreason", new { id = rfpreason.ReasonId }, rfpreason);
        }

        // DELETE: api/Rfpreasons/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRfpreason(Guid id)
        {
            var rfpreason = await _context.Rfpreasons.FindAsync(id);
            if (rfpreason == null)
            {
                return NotFound();
            }

            _context.Rfpreasons.Remove(rfpreason);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RfpreasonExists(Guid id)
        {
            return _context.Rfpreasons.Any(e => e.ReasonId == id);
        }
    }
}
