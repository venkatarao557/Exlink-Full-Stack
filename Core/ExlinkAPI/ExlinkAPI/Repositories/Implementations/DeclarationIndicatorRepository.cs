using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class DeclarationIndicatorRepository : IDeclarationIndicatorRepository
    {
        private readonly ExdocContext _context;

        public DeclarationIndicatorRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<DeclarationIndicator>> GetAllAsync()
        {
            return await _context.DeclarationIndicators.ToListAsync();
        }

        public async Task<DeclarationIndicator?> GetByIdAsync(Guid id)
        {
            return await _context.DeclarationIndicators.FindAsync(id);
        }

        public async Task<DeclarationIndicator> AddAsync(DeclarationIndicator entity)
        {
            _context.DeclarationIndicators.Add(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task UpdateAsync(DeclarationIndicator entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.DeclarationIndicators.FindAsync(id);
            if (entity != null)
            {
                _context.DeclarationIndicators.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.DeclarationIndicators.AnyAsync(e => e.DeclarationId == id);
        }
    }
}