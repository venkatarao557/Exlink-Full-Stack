using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IEUCountryRepository
    {
        Task<IEnumerable<EUCountry>> GetAllAsync();
        Task<EUCountry?> GetByIdAsync(Guid id);
        Task<EUCountry> AddAsync(EUCountry entity);
        Task UpdateAsync(EUCountry entity);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}
