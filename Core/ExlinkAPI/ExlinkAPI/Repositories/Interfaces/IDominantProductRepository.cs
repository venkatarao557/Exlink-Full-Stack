using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IDominantProductRepository
    {
        Task<IEnumerable<DominantProduct>> GetAllAsync();
        Task<DominantProduct?> GetByIdAsync(Guid id);
        Task<DominantProduct> AddAsync(DominantProduct entity);
        Task UpdateAsync(DominantProduct entity);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}