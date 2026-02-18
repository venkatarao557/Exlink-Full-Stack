using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CurrencyRepository : ICurrencyRepository
    {
        private readonly ExdocContext _context;

        public CurrencyRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CurrencyDto>> GetAllAsync()
        {
            return await _context.Currencies
                .Select(c => new CurrencyDto
                {
                    CurrencyId = c.CurrencyId,
                    CurrencyUnit = c.CurrencyUnit,
                    Description = c.Description
                }).ToListAsync();
        }

        public async Task<CurrencyDto?> GetByIdAsync(Guid id)
        {
            var currency = await _context.Currencies.FindAsync(id);
            if (currency == null) return null;

            return new CurrencyDto
            {
                CurrencyId = currency.CurrencyId,
                CurrencyUnit = currency.CurrencyUnit,
                Description = currency.Description
            };
        }

        public async Task<CurrencyDto?> GetByUnitAsync(string unit)
        {
            var currency = await _context.Currencies
                .FirstOrDefaultAsync(c => c.CurrencyUnit == unit);

            if (currency == null) return null;

            return new CurrencyDto
            {
                CurrencyId = currency.CurrencyId,
                CurrencyUnit = currency.CurrencyUnit,
                Description = currency.Description
            };
        }

        public async Task<CurrencyDto> CreateAsync(CurrencyDto dto)
        {
            var entity = new Currency
            {
                CurrencyId = dto.CurrencyId == Guid.Empty ? Guid.NewGuid() : dto.CurrencyId,
                CurrencyUnit = dto.CurrencyUnit,
                Description = dto.Description
            };

            _context.Currencies.Add(entity);
            await _context.SaveChangesAsync();

            dto.CurrencyId = entity.CurrencyId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, CurrencyDto dto)
        {
            var entity = await _context.Currencies.FindAsync(id);
            if (entity == null) return false;

            entity.CurrencyUnit = dto.CurrencyUnit;
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
            var currency = await _context.Currencies.FindAsync(id);
            if (currency == null) return false;

            _context.Currencies.Remove(currency);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> UnitExistsAsync(string unit)
        {
            return await _context.Currencies.AnyAsync(c => c.CurrencyUnit == unit);
        }
    }
}