using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class SupplementaryCodeRepository : ISupplementaryCodeRepository
    {
        private readonly ExdocContext _context;

        public SupplementaryCodeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<SupplementaryCode>> GetAllAsync()
        {
            return await _context.SupplementaryCodes.ToListAsync();
        }

        public async Task<SupplementaryCode?> GetByIdAsync(Guid id)
        {
            return await _context.SupplementaryCodes.FindAsync(id);
        }

        public async Task<SupplementaryCode> AddAsync(SupplementaryCode supplementaryCode)
        {
            if (supplementaryCode.SupplementaryCodeId == Guid.Empty)
            {
                supplementaryCode.SupplementaryCodeId = Guid.NewGuid();
            }

            _context.SupplementaryCodes.Add(supplementaryCode);
            await _context.SaveChangesAsync();
            return supplementaryCode;
        }

        public async Task UpdateAsync(SupplementaryCode supplementaryCode)
        {
            _context.Entry(supplementaryCode).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.SupplementaryCodes.FindAsync(id);
            if (entity != null)
            {
                _context.SupplementaryCodes.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.SupplementaryCodes.AnyAsync(e => e.SupplementaryCodeId == id);
        }
    }
}