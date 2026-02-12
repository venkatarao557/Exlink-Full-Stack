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
    public class ProcessTypesController : ControllerBase
    {
        private readonly ExdocContext _context;

        public ProcessTypesController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/ProcessTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProcessType>>> GetProcessTypes()
        {
            return await _context.ProcessTypes.ToListAsync();
        }

        // GET: api/ProcessTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProcessType>> GetProcessType(Guid id)
        {
            var processType = await _context.ProcessTypes.FindAsync(id);

            if (processType == null)
            {
                return NotFound();
            }

            return processType;
        }

        // PUT: api/ProcessTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProcessType(Guid id, ProcessType processType)
        {
            if (id != processType.ProcessTypeId)
            {
                return BadRequest();
            }

            _context.Entry(processType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProcessTypeExists(id))
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

        // POST: api/ProcessTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ProcessType>> PostProcessType(ProcessType processType)
        {
            _context.ProcessTypes.Add(processType);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProcessType", new { id = processType.ProcessTypeId }, processType);
        }

        // DELETE: api/ProcessTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProcessType(Guid id)
        {
            var processType = await _context.ProcessTypes.FindAsync(id);
            if (processType == null)
            {
                return NotFound();
            }

            _context.ProcessTypes.Remove(processType);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProcessTypeExists(Guid id)
        {
            return _context.ProcessTypes.Any(e => e.ProcessTypeId == id);
        }
    }
}
