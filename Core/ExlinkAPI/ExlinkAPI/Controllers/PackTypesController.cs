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
    public class PackTypesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public PackTypesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/PackTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PackType>>> GetPackTypes()
        {
            return await _context.PackTypes.ToListAsync();
        }

        // GET: api/PackTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PackType>> GetPackType(Guid id)
        {
            var packType = await _context.PackTypes.FindAsync(id);

            if (packType == null)
            {
                return NotFound();
            }

            return packType;
        }

        // PUT: api/PackTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPackType(Guid id, PackType packType)
        {
            if (id != packType.PackTypeId)
            {
                return BadRequest();
            }

            _context.Entry(packType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PackTypeExists(id))
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

        // POST: api/PackTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PackType>> PostPackType(PackType packType)
        {
            _context.PackTypes.Add(packType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPackType", new { id = packType.PackTypeId }, packType);
        }

        // DELETE: api/PackTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePackType(Guid id)
        {
            var packType = await _context.PackTypes.FindAsync(id);
            if (packType == null)
            {
                return NotFound();
            }

            _context.PackTypes.Remove(packType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PackTypeExists(Guid id)
        {
            return _context.PackTypes.Any(e => e.PackTypeId == id);
        }
    }
}
