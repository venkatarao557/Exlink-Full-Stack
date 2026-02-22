using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class TransportModeRepository : ITransportModeRepository
    {
        private readonly ExdocContext _context;

        public TransportModeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<TransportModeDto>> GetAllAsync()
        {
            return await _context.TransportModes
                .Select(t => new TransportModeDto
                {
                    TransportModeId = t.TransportModeId,
                    ModeCode = t.ModeCode,
                    Description = t.Description
                }).ToListAsync();
        }

        public async Task<TransportModeDto?> GetByIdAsync(Guid id)
        {
            var mode = await _context.TransportModes.FindAsync(id);
            if (mode == null) return null;

            return new TransportModeDto
            {
                TransportModeId = mode.TransportModeId,
                ModeCode = mode.ModeCode,
                Description = mode.Description
            };
        }

        public async Task<TransportModeDto> CreateAsync(TransportModeDto dto)
        {
            var entity = new TransportMode
            {
                TransportModeId = dto.TransportModeId == Guid.Empty ? Guid.NewGuid() : dto.TransportModeId,
                ModeCode = dto.ModeCode,
                Description = dto.Description
            };

            _context.TransportModes.Add(entity);
            await _context.SaveChangesAsync();

            dto.TransportModeId = entity.TransportModeId;
            return dto;
        }

        public async Task UpdateAsync(TransportModeDto dto)
        {
            var entity = await _context.TransportModes.FindAsync(dto.TransportModeId);
            if (entity != null)
            {
                entity.ModeCode = dto.ModeCode;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.TransportModes.FindAsync(id);
            if (entity != null)
            {
                _context.TransportModes.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.TransportModes.AnyAsync(e => e.TransportModeId == id);
        }
    }
}