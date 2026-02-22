using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class PackageTypeRepository : IPackageTypeRepository
    {
        private readonly ExdocContext _context;

        public PackageTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PackageTypeDto>> GetAllAsync()
        {
            return await _context.PackageTypes
                .Select(p => new PackageTypeDto
                {
                    PackageTypeId = p.PackageTypeId,
                    PackageTypeCode = p.PackageTypeCode,
                    Description = p.Description
                }).ToListAsync();
        }

        public async Task<PackageTypeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.PackageTypes.FindAsync(id);
            if (entity == null) return null;

            return new PackageTypeDto
            {
                PackageTypeId = entity.PackageTypeId,
                PackageTypeCode = entity.PackageTypeCode,
                Description = entity.Description
            };
        }

        public async Task<PackageTypeDto> CreateAsync(PackageTypeDto dto)
        {
            var entity = new PackageType
            {
                PackageTypeId = Guid.NewGuid(),
                PackageTypeCode = dto.PackageTypeCode,
                Description = dto.Description
            };

            _context.PackageTypes.Add(entity);
            await _context.SaveChangesAsync();

            dto.PackageTypeId = entity.PackageTypeId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, PackageTypeDto dto)
        {
            var entity = await _context.PackageTypes.FindAsync(id);
            if (entity == null) return false;

            entity.PackageTypeCode = dto.PackageTypeCode;
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
            var entity = await _context.PackageTypes.FindAsync(id);
            if (entity == null) return false;

            _context.PackageTypes.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}