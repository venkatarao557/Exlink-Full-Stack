using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CountryRepository : ICountryRepository
    {
        private readonly ExdocContext _context;

        public CountryRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CountryDto>> GetAllAsync()
        {
            return await _context.Countries
                .OrderBy(c => c.CountryName)
                .Select(c => new CountryDto
                {
                    CountryId = c.CountryId,
                    CountryCode = c.CountryCode,
                    CountryName = c.CountryName
                }).ToListAsync();
        }

        public async Task<CountryDto?> GetByIdAsync(Guid id)
        {
            var country = await _context.Countries.FindAsync(id);
            if (country == null) return null;

            return new CountryDto
            {
                CountryId = country.CountryId,
                CountryCode = country.CountryCode,
                CountryName = country.CountryName
            };
        }

        public async Task<CountryDto?> GetByCodeAsync(string code)
        {
            return await _context.Countries
                .Where(c => c.CountryCode == code)
                .Select(c => new CountryDto
                {
                    CountryId = c.CountryId,
                    CountryCode = c.CountryCode,
                    CountryName = c.CountryName
                }).FirstOrDefaultAsync();
        }

        public async Task<CountryDto> CreateAsync(CountryDto countryDto)
        {
            var entity = new Country
            {
                CountryId = countryDto.CountryId == Guid.Empty ? Guid.NewGuid() : countryDto.CountryId,
                CountryCode = countryDto.CountryCode,
                CountryName = countryDto.CountryName
            };

            _context.Countries.Add(entity);
            await _context.SaveChangesAsync();

            countryDto.CountryId = entity.CountryId;
            return countryDto;
        }

        public async Task<bool> UpdateAsync(Guid id, CountryDto countryDto)
        {
            var entity = await _context.Countries.FindAsync(id);
            if (entity == null) return false;

            entity.CountryCode = countryDto.CountryCode;
            entity.CountryName = countryDto.CountryName;

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
            var country = await _context.Countries.FindAsync(id);
            if (country == null) return false;

            _context.Countries.Remove(country);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> CodeExistsAsync(string code)
        {
            return await _context.Countries.AnyAsync(c => c.CountryCode == code);
        }
    }
}