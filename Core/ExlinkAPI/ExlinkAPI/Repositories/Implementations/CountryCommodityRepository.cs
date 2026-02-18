using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CountryCommodityRepository : ICountryCommodityRepository
    {
        private readonly ExdocContext _context;

        public CountryCommodityRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CountryCommodityDto>> GetAllAsync()
        {
            return await _context.CountryCommodities
                .Select(c => new CountryCommodityDto
                {
                    CountryCommodityId = c.CountryCommodityId,
                    CountryCode = c.CountryCode,
                    CountryName = c.CountryName,
                    Commodities = c.Commodities
                }).ToListAsync();
        }

        public async Task<CountryCommodityDto?> GetByCountryCodeAsync(string countryCode)
        {
            var mapping = await _context.CountryCommodities
                .FirstOrDefaultAsync(c => c.CountryCode == countryCode);

            if (mapping == null) return null;

            return new CountryCommodityDto
            {
                CountryCommodityId = mapping.CountryCommodityId,
                CountryCode = mapping.CountryCode,
                CountryName = mapping.CountryName,
                Commodities = mapping.Commodities
            };
        }

        public async Task<CountryCommodityDto?> GetByIdAsync(Guid id)
        {
            var mapping = await _context.CountryCommodities.FindAsync(id);
            if (mapping == null) return null;

            return new CountryCommodityDto
            {
                CountryCommodityId = mapping.CountryCommodityId,
                CountryCode = mapping.CountryCode,
                CountryName = mapping.CountryName,
                Commodities = mapping.Commodities
            };
        }

        public async Task<CountryCommodityDto> CreateAsync(CountryCommodityDto dto)
        {
            var entity = new CountryCommodity
            {
                CountryCommodityId = dto.CountryCommodityId == Guid.Empty ? Guid.NewGuid() : dto.CountryCommodityId,
                CountryCode = dto.CountryCode,
                CountryName = dto.CountryName,
                Commodities = dto.Commodities
            };

            _context.CountryCommodities.Add(entity);
            await _context.SaveChangesAsync();

            dto.CountryCommodityId = entity.CountryCommodityId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, CountryCommodityDto dto)
        {
            var entity = await _context.CountryCommodities.FindAsync(id);
            if (entity == null) return false;

            entity.CountryCode = dto.CountryCode;
            entity.CountryName = dto.CountryName;
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
            var mapping = await _context.CountryCommodities.FindAsync(id);
            if (mapping == null) return false;

            _context.CountryCommodities.Remove(mapping);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> MappingExistsAsync(string countryCode)
        {
            return await _context.CountryCommodities.AnyAsync(c => c.CountryCode == countryCode);
        }
    }
}