using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class RegionRepository : IRegionRepository
    {
        private readonly ExdocContext _context;

        public RegionRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RegionDto>> GetAllAsync()
        {
            return await _context.Regions
                .Select(r => new RegionDto
                {
                    RegionId = r.RegionId,
                    RegionCode = r.RegionCode,
                    RegionName = r.RegionName,
                    Commodities = r.Commodities
                }).ToListAsync();
        }

        public async Task<RegionDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.Regions.FindAsync(id);
            if (entity == null) return null;

            return new RegionDto
            {
                RegionId = entity.RegionId,
                RegionCode = entity.RegionCode,
                RegionName = entity.RegionName,
                Commodities = entity.Commodities
            };
        }

        public async Task<RegionDto> CreateAsync(RegionDto dto)
        {
            var entity = new Region
            {
                RegionId = Guid.NewGuid(),
                RegionCode = dto.RegionCode,
                RegionName = dto.RegionName,
                Commodities = dto.Commodities
            };

            _context.Regions.Add(entity);
            await _context.SaveChangesAsync();

            dto.RegionId = entity.RegionId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, RegionDto dto)
        {
            var entity = await _context.Regions.FindAsync(id);
            if (entity == null) return false;

            entity.RegionCode = dto.RegionCode;
            entity.RegionName = dto.RegionName;
            entity.Commodities = dto.Commodities;

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
            var entity = await _context.Regions.FindAsync(id);
            if (entity == null) return false;

            _context.Regions.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}