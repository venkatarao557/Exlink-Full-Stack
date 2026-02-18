using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICountryRepository
    {
        Task<IEnumerable<CountryDto>> GetAllAsync();
        Task<CountryDto?> GetByIdAsync(Guid id);
        Task<CountryDto?> GetByCodeAsync(string code);
        Task<CountryDto> CreateAsync(CountryDto countryDto);
        Task<bool> UpdateAsync(Guid id, CountryDto countryDto);
        Task<bool> DeleteAsync(Guid id);
        Task<bool> CodeExistsAsync(string code);
    }
}
