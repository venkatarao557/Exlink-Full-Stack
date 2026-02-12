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
    public class PackageTypesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public PackageTypesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/PackageTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PackageType>>> GetPackageTypes()
        {
            return await _context.PackageTypes.ToListAsync();
        }

        // GET: api/PackageTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PackageType>> GetPackageType(Guid id)
        {
            var packageType = await _context.PackageTypes.FindAsync(id);

            if (packageType == null)
            {
                return NotFound();
            }

            return packageType;
        }

        // PUT: api/PackageTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPackageType(Guid id, PackageType packageType)
        {
            if (id != packageType.PackageTypeId)
            {
                return BadRequest();
            }

            _context.Entry(packageType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PackageTypeExists(id))
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

        // POST: api/PackageTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PackageType>> PostPackageType(PackageType packageType)
        {
            _context.PackageTypes.Add(packageType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPackageType", new { id = packageType.PackageTypeId }, packageType);
        }

        // DELETE: api/PackageTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePackageType(Guid id)
        {
            var packageType = await _context.PackageTypes.FindAsync(id);
            if (packageType == null)
            {
                return NotFound();
            }

            _context.PackageTypes.Remove(packageType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PackageTypeExists(Guid id)
        {
            return _context.PackageTypes.Any(e => e.PackageTypeId == id);
        }
    }
}
