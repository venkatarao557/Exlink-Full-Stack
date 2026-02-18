using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICustomsWeightUnitRepository
    {
        Task<IEnumerable<CustomsWeightUnit>> GetAllAsync();
        Task<CustomsWeightUnit?> GetByIdAsync(Guid id);
        Task<CustomsWeightUnit> AddAsync(CustomsWeightUnit entity);
        Task UpdateAsync(CustomsWeightUnit entity);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}