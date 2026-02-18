using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICutTypeRepository
    {
        Task<IEnumerable<CutType>> GetAllAsync();
        Task<CutType?> GetByIdAsync(Guid id);
        Task AddAsync(CutType cutType);
        void Update(CutType cutType);
        Task DeleteAsync(Guid id);
        Task<bool> SaveChangesAsync();
        Task<bool> ExistsAsync(Guid id);
    }
}