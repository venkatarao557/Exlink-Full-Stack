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
    public class CutTypesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CutTypesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CutTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CutType>>> GetCutTypes()
        {
            return await _context.CutTypes.ToListAsync();
        }

        // GET: api/CutTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CutType>> GetCutType(Guid id)
        {
            var cutType = await _context.CutTypes.FindAsync(id);

            if (cutType == null)
            {
                return NotFound();
            }

            return cutType;
        }

        // PUT: api/CutTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCutType(Guid id, CutType cutType)
        {
            if (id != cutType.CutTypeId)
            {
                return BadRequest();
            }

            _context.Entry(cutType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CutTypeExists(id))
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

        // POST: api/CutTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CutType>> PostCutType(CutType cutType)
        {
            _context.CutTypes.Add(cutType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCutType", new { id = cutType.CutTypeId }, cutType);
        }

        // DELETE: api/CutTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCutType(Guid id)
        {
            var cutType = await _context.CutTypes.FindAsync(id);
            if (cutType == null)
            {
                return NotFound();
            }

            _context.CutTypes.Remove(cutType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CutTypeExists(Guid id)
        {
            return _context.CutTypes.Any(e => e.CutTypeId == id);
        }
    }
}
