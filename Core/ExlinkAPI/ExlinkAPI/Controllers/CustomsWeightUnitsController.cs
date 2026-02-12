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
    public class CustomsWeightUnitsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public CustomsWeightUnitsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/CustomsWeightUnits
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomsWeightUnit>>> GetCustomsWeightUnits()
        {
            return await _context.CustomsWeightUnits.ToListAsync();
        }

        // GET: api/CustomsWeightUnits/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomsWeightUnit>> GetCustomsWeightUnit(Guid id)
        {
            var customsWeightUnit = await _context.CustomsWeightUnits.FindAsync(id);

            if (customsWeightUnit == null)
            {
                return NotFound();
            }

            return customsWeightUnit;
        }

        // PUT: api/CustomsWeightUnits/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomsWeightUnit(Guid id, CustomsWeightUnit customsWeightUnit)
        {
            if (id != customsWeightUnit.CustomsWeightId)
            {
                return BadRequest();
            }

            _context.Entry(customsWeightUnit).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomsWeightUnitExists(id))
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

        // POST: api/CustomsWeightUnits
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CustomsWeightUnit>> PostCustomsWeightUnit(CustomsWeightUnit customsWeightUnit)
        {
            _context.CustomsWeightUnits.Add(customsWeightUnit);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCustomsWeightUnit", new { id = customsWeightUnit.CustomsWeightId }, customsWeightUnit);
        }

        // DELETE: api/CustomsWeightUnits/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomsWeightUnit(Guid id)
        {
            var customsWeightUnit = await _context.CustomsWeightUnits.FindAsync(id);
            if (customsWeightUnit == null)
            {
                return NotFound();
            }

            _context.CustomsWeightUnits.Remove(customsWeightUnit);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CustomsWeightUnitExists(Guid id)
        {
            return _context.CustomsWeightUnits.Any(e => e.CustomsWeightId == id);
        }
    }
}
