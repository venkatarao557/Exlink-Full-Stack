using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class PackTypeRepository : IPackTypeRepository
    {
        private readonly ExdocContext _context;

        public PackTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PackTypeDto>> GetAllAsync()
        {
            return await _context.PackTypes
                .Select(p => new PackTypeDto
                {
                    PackTypeId = p.PackTypeId,
                    PackTypeCode = p.PackTypeCode,
                    Description = p.Description
                }).ToListAsync();
        }

        public async Task<PackTypeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.PackTypes.FindAsync(id);
            if (entity == null) return null;

            return new PackTypeDto
            {
                PackTypeId = entity.PackTypeId,
                PackTypeCode = entity.PackTypeCode,
                Description = entity.Description
            };
        }

        public async Task<PackTypeDto> CreateAsync(PackTypeDto dto)
        {
            var entity = new PackType
            {
                PackTypeId = Guid.NewGuid(),
                PackTypeCode = dto.PackTypeCode,
                Description = dto.Description
            };

            _context.PackTypes.Add(entity);
            await _context.SaveChangesAsync();

            dto.PackTypeId = entity.PackTypeId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, PackTypeDto dto)
        {
            var entity = await _context.PackTypes.FindAsync(id);
            if (entity == null) return false;

            entity.PackTypeCode = dto.PackTypeCode;
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
            var entity = await _context.PackTypes.FindAsync(id);
            if (entity == null) return false;

            _context.PackTypes.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}