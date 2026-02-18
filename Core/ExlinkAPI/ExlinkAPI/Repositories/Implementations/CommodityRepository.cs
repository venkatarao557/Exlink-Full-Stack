using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CommodityRepository : ICommodityRepository
    {
        private readonly ExdocContext _context;

        public CommodityRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CommodityDto>> GetAllAsync()
        {
            return await _context.Commodities
                .Select(c => new CommodityDto
                {
                    CommodityId = c.CommodityId,
                    CommodityCode = c.CommodityCode,
                    Description = c.Description
                }).ToListAsync();
        }

        public async Task<CommodityDto?> GetByIdAsync(Guid id)
        {
            var commodity = await _context.Commodities.FindAsync(id);
            if (commodity == null) return null;

            return new CommodityDto
            {
                CommodityId = commodity.CommodityId,
                CommodityCode = commodity.CommodityCode,
                Description = commodity.Description
            };
        }

        public async Task<CommodityDto> CreateAsync(CommodityDto commodityDto)
        {
            var entity = new Commodity
            {
                CommodityId = commodityDto.CommodityId == Guid.Empty ? Guid.NewGuid() : commodityDto.CommodityId,
                CommodityCode = commodityDto.CommodityCode,
                Description = commodityDto.Description
            };

            _context.Commodities.Add(entity);
            await _context.SaveChangesAsync();

            commodityDto.CommodityId = entity.CommodityId;
            return commodityDto;
        }

        public async Task<bool> UpdateAsync(Guid id, CommodityDto commodityDto)
        {
            var entity = await _context.Commodities.FindAsync(id);
            if (entity == null) return false;

            entity.CommodityCode = commodityDto.CommodityCode;
            entity.Description = commodityDto.Description;

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
            var commodity = await _context.Commodities.FindAsync(id);
            if (commodity == null) return false;

            _context.Commodities.Remove(commodity);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> CodeExistsAsync(string code)
        {
            return await _context.Commodities.AnyAsync(c => c.CommodityCode == code);
        }
    }
}