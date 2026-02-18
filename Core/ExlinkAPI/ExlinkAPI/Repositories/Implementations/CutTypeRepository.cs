using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CutTypeRepository : ICutTypeRepository
    {
        private readonly ExdocContext _context;

        public CutTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CutType>> GetAllAsync() =>
            await _context.CutTypes.ToListAsync();

        public async Task<CutType?> GetByIdAsync(Guid id) =>
            await _context.CutTypes.FindAsync(id);

        public async Task AddAsync(CutType cutType) =>
            await _context.CutTypes.AddAsync(cutType);

        public void Update(CutType cutType) =>
            _context.Entry(cutType).State = EntityState.Modified;

        public async Task DeleteAsync(Guid id)
        {
            var cutType = await _context.CutTypes.FindAsync(id);
            if (cutType != null) _context.CutTypes.Remove(cutType);
        }

        public async Task<bool> SaveChangesAsync() =>
            (await _context.SaveChangesAsync()) > 0;

        public async Task<bool> ExistsAsync(Guid id) =>
            await _context.CutTypes.AnyAsync(e => e.CutTypeId == id);
    }
}