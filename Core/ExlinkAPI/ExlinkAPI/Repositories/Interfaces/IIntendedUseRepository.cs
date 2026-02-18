using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IIntendedUseRepository
    {
        Task<IEnumerable<IntendedUse>> GetAllAsync();
        Task<IntendedUse?> GetByIdAsync(Guid id);
        Task<IntendedUse> AddAsync(IntendedUse entity);
        Task UpdateAsync(IntendedUse entity);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}