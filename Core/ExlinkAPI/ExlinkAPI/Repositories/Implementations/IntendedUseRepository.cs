using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class IntendedUseRepository : IIntendedUseRepository
    {
        private readonly ExdocContext _context;

        public IntendedUseRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<IntendedUse>> GetAllAsync()
        {
            return await _context.IntendedUses.ToListAsync();
        }

        public async Task<IntendedUse?> GetByIdAsync(Guid id)
        {
            return await _context.IntendedUses.FindAsync(id);
        }

        public async Task<IntendedUse> AddAsync(IntendedUse entity)
        {
            _context.IntendedUses.Add(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(IntendedUse entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.IntendedUses.FindAsync(id);
            if (entity != null)
            {
                _context.IntendedUses.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.IntendedUses.AnyAsync(e => e.IntendedUseId == id);
        }
    }
}