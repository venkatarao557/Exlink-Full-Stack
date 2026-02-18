using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class EUCountryRepository : IEUCountryRepository
    {
        private readonly ExdocContext _context;

        public EUCountryRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<EUCountry>> GetAllAsync()
        {
            return await _context.Eucountries.ToListAsync();
        }

        public async Task<EUCountry?> GetByIdAsync(Guid id)
        {
            return await _context.Eucountries.FindAsync(id);
        }

        public async Task<EUCountry> AddAsync(EUCountry entity)
        {
            _context.Eucountries.Add(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(EUCountry entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.Eucountries.FindAsync(id);
            if (entity != null)
            {
                _context.Eucountries.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.Eucountries.AnyAsync(e => e.EUCountryId == id);
        }
    }
}