using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICurrencyRepository
    {
        Task<IEnumerable<CurrencyDto>> GetAllAsync();
        Task<CurrencyDto?> GetByIdAsync(Guid id);
        Task<CurrencyDto?> GetByUnitAsync(string unit);
        Task<CurrencyDto> CreateAsync(CurrencyDto dto);
        Task<bool> UpdateAsync(Guid id, CurrencyDto dto);
        Task<bool> DeleteAsync(Guid id);
        Task<bool> UnitExistsAsync(string unit);
    }
}