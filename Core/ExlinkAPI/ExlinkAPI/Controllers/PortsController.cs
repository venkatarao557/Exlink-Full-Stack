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
    public class PortsController : ControllerBase
    {
        private readonly ExdocContext _context;

        public PortsController(ExdocContext context)
        {
            _context = context;
        }

        // GET: api/Ports
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Port>>> GetPorts()
        {
            return await _context.Ports.ToListAsync();
        }

        // GET: api/Ports/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Port>> GetPort(Guid id)
        {
            var port = await _context.Ports.FindAsync(id);

            if (port == null)
            {
                return NotFound();
            }

            return port;
        }

        // PUT: api/Ports/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPort(Guid id, Port port)
        {
            if (id != port.PortId)
            {
                return BadRequest();
            }

            _context.Entry(port).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PortExists(id))
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

        // POST: api/Ports
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Port>> PostPort(Port port)
        {
            _context.Ports.Add(port);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPort", new { id = port.PortId }, port);
        }

        // DELETE: api/Ports/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePort(Guid id)
        {
            var port = await _context.Ports.FindAsync(id);
            if (port == null)
            {
                return NotFound();
            }

            _context.Ports.Remove(port);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PortExists(Guid id)
        {
            return _context.Ports.Any(e => e.PortId == id);
        }
    }
}
