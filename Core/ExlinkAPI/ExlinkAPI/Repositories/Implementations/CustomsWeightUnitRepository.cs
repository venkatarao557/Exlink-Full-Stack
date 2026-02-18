using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CustomsWeightUnitRepository : ICustomsWeightUnitRepository
    {
        private readonly ExdocContext _context;

        public CustomsWeightUnitRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CustomsWeightUnit>> GetAllAsync()
        {
            return await _context.CustomsWeightUnits.ToListAsync();
        }

        public async Task<CustomsWeightUnit?> GetByIdAsync(Guid id)
        {
            return await _context.CustomsWeightUnits.FindAsync(id);
        }

        public async Task<CustomsWeightUnit> AddAsync(CustomsWeightUnit entity)
        {
            _context.CustomsWeightUnits.Add(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(CustomsWeightUnit entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.CustomsWeightUnits.FindAsync(id);
            if (entity != null)
            {
                _context.CustomsWeightUnits.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.CustomsWeightUnits.AnyAsync(e => e.CustomsWeightId == id);
        }
    }
}