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
    public class NatureOfCommoditiesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public NatureOfCommoditiesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/NatureOfCommodities
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NatureOfCommodity>>> GetNatureOfCommodities()
        {
            return await _context.NatureOfCommodities.ToListAsync();
        }

        // GET: api/NatureOfCommodities/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NatureOfCommodity>> GetNatureOfCommodity(Guid id)
        {
            var natureOfCommodity = await _context.NatureOfCommodities.FindAsync(id);

            if (natureOfCommodity == null)
            {
                return NotFound();
            }

            return natureOfCommodity;
        }

        // PUT: api/NatureOfCommodities/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNatureOfCommodity(Guid id, NatureOfCommodity natureOfCommodity)
        {
            if (id != natureOfCommodity.NatureId)
            {
                return BadRequest();
            }

            _context.Entry(natureOfCommodity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NatureOfCommodityExists(id))
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

        // POST: api/NatureOfCommodities
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<NatureOfCommodity>> PostNatureOfCommodity(NatureOfCommodity natureOfCommodity)
        {
            _context.NatureOfCommodities.Add(natureOfCommodity);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetNatureOfCommodity", new { id = natureOfCommodity.NatureId }, natureOfCommodity);
        }

        // DELETE: api/NatureOfCommodities/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNatureOfCommodity(Guid id)
        {
            var natureOfCommodity = await _context.NatureOfCommodities.FindAsync(id);
            if (natureOfCommodity == null)
            {
                return NotFound();
            }

            _context.NatureOfCommodities.Remove(natureOfCommodity);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NatureOfCommodityExists(Guid id)
        {
            return _context.NatureOfCommodities.Any(e => e.NatureId == id);
        }
    }
}
