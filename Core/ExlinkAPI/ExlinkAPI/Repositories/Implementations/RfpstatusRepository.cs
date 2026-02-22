using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class RfpstatusRepository : IRfpstatusRepository
    {
        private readonly ExdocContext _context;

        public RfpstatusRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RfpstatusDto>> GetAllAsync()
        {
            return await _context.Rfpstatuses
                .Select(s => new RfpstatusDto
                {
                    StatusId = s.StatusId,
                    StatusCode = s.StatusCode,
                    Description = s.Description
                }).ToListAsync();
        }

        public async Task<RfpstatusDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.Rfpstatuses.FindAsync(id);
            if (entity == null) return null;

            return new RfpstatusDto
            {
                StatusId = entity.StatusId,
                StatusCode = entity.StatusCode,
                Description = entity.Description
            };
        }

        public async Task<RfpstatusDto> CreateAsync(RfpstatusDto dto)
        {
            var entity = new Rfpstatus
            {
                StatusId = Guid.NewGuid(),
                StatusCode = dto.StatusCode,
                Description = dto.Description
            };

            _context.Rfpstatuses.Add(entity);
            await _context.SaveChangesAsync();

            dto.StatusId = entity.StatusId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, RfpstatusDto dto)
        {
            var entity = await _context.Rfpstatuses.FindAsync(id);
            if (entity == null) return false;

            entity.StatusCode = dto.StatusCode;
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
            var entity = await _context.Rfpstatuses.FindAsync(id);
            if (entity == null) return false;

            _context.Rfpstatuses.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}