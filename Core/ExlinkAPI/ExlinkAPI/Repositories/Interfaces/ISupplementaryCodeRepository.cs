using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ISupplementaryCodeRepository
    {
        Task<IEnumerable<SupplementaryCode>> GetAllAsync();
        Task<SupplementaryCode?> GetByIdAsync(Guid id);
        Task<SupplementaryCode> AddAsync(SupplementaryCode supplementaryCode);
        Task UpdateAsync(SupplementaryCode supplementaryCode);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}