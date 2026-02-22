using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class RfpreasonRepository : IRfpreasonRepository
    {
        private readonly ExdocContext _context;

        public RfpreasonRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RfpreasonDto>> GetAllAsync()
        {
            return await _context.Rfpreasons
                .Select(r => new RfpreasonDto
                {
                    ReasonId = r.ReasonId,
                    ReasonCode = r.ReasonCode,
                    Description = r.Description
                }).ToListAsync();
        }

        public async Task<RfpreasonDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.Rfpreasons.FindAsync(id);
            if (entity == null) return null;

            return new RfpreasonDto
            {
                ReasonId = entity.ReasonId,
                ReasonCode = entity.ReasonCode,
                Description = entity.Description
            };
        }

        public async Task<RfpreasonDto> CreateAsync(RfpreasonDto dto)
        {
            var entity = new Rfpreason
            {
                ReasonId = Guid.NewGuid(),
                ReasonCode = dto.ReasonCode,
                Description = dto.Description
            };

            _context.Rfpreasons.Add(entity);
            await _context.SaveChangesAsync();

            dto.ReasonId = entity.ReasonId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, RfpreasonDto dto)
        {
            var entity = await _context.Rfpreasons.FindAsync(id);
            if (entity == null) return false;

            entity.ReasonCode = dto.ReasonCode;
            entity.Description = dto.Description;

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
            var entity = await _context.Rfpreasons.FindAsync(id);
            if (entity == null) return false;

            _context.Rfpreasons.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}