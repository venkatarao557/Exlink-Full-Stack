using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class DominantProductRepository : IDominantProductRepository
    {
        private readonly ExdocContext _context;

        public DominantProductRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<DominantProduct>> GetAllAsync()
        {
            return await _context.DominantProducts.ToListAsync();
        }

        public async Task<DominantProduct?> GetByIdAsync(Guid id)
        {
            return await _context.DominantProducts.FindAsync(id);
        }

        public async Task<DominantProduct> AddAsync(DominantProduct entity)
        {
            _context.DominantProducts.Add(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(DominantProduct entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.DominantProducts.FindAsync(id);
            if (entity != null)
            {
                _context.DominantProducts.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.DominantProducts.AnyAsync(e => e.DominantProductId == id);
        }
    }
}