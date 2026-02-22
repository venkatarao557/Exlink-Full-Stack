using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class PortRepository : IPortRepository
    {
        private readonly ExdocContext _context;

        public PortRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PortDto>> GetAllAsync()
        {
            return await _context.Ports
                .Select(p => new PortDto
                {
                    PortId = p.PortId,
                    PortCode = p.PortCode,
                    PortName = p.PortName
                }).ToListAsync();
        }

        public async Task<PortDto?> GetByIdAsync(Guid id)
        {
            var port = await _context.Ports.FindAsync(id);
            if (port == null) return null;

            return new PortDto
            {
                PortId = port.PortId,
                PortCode = port.PortCode,
                PortName = port.PortName
            };
        }

        public async Task<PortDto> CreateAsync(PortDto dto)
        {
            var port = new Port
            {
                PortId = Guid.NewGuid(),
                PortCode = dto.PortCode,
                PortName = dto.PortName
            };

            _context.Ports.Add(port);
            await _context.SaveChangesAsync();

            dto.PortId = port.PortId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, PortDto dto)
        {
            var port = await _context.Ports.FindAsync(id);
            if (port == null) return false;

            port.PortCode = dto.PortCode;
            port.PortName = dto.PortName;

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                return false;
            }
        }

        public async Task<bool> DeleteAsync(Guid id)
        {
            var port = await _context.Ports.FindAsync(id);
            if (port == null) return false;

            _context.Ports.Remove(port);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}