using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class NatureOfCommodityRepository : INatureOfCommodityRepository
    {
        private readonly ExdocContext _context;

        public NatureOfCommodityRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<NatureOfCommodityDto>> GetAllAsync()
        {
            return await _context.NatureOfCommodities
                .Select(n => new NatureOfCommodityDto
                {
                    NatureId = n.NatureId,
                    NatureOfCommodityCode = n.NatureOfCommodityCode,
                    Description = n.Description
                }).ToListAsync();
        }

        public async Task<NatureOfCommodityDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.NatureOfCommodities.FindAsync(id);
            if (entity == null) return null;

            return new NatureOfCommodityDto
            {
                NatureId = entity.NatureId,
                NatureOfCommodityCode = entity.NatureOfCommodityCode,
                Description = entity.Description
            };
        }

        public async Task<NatureOfCommodityDto> CreateAsync(NatureOfCommodityDto dto)
        {
            var entity = new NatureOfCommodity
            {
                NatureId = Guid.NewGuid(),
                NatureOfCommodityCode = dto.NatureOfCommodityCode,
                Description = dto.Description
            };

            _context.NatureOfCommodities.Add(entity);
            await _context.SaveChangesAsync();

            dto.NatureId = entity.NatureId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, NatureOfCommodityDto dto)
        {
            var entity = await _context.NatureOfCommodities.FindAsync(id);
            if (entity == null) return false;

            entity.NatureOfCommodityCode = dto.NatureOfCommodityCode;
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
            var entity = await _context.NatureOfCommodities.FindAsync(id);
            if (entity == null) return false;

            _context.NatureOfCommodities.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}