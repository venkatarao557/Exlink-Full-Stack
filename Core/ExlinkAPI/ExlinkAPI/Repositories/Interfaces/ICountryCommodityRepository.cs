using ExlinkAPI.DTOs;
namespace ExlinkAPI.Repositories.Interfaces
{
        public interface ICountryCommodityRepository
        {
            Task<IEnumerable<CountryCommodityDto>> GetAllAsync();
            Task<CountryCommodityDto?> GetByCountryCodeAsync(string countryCode);
            Task<CountryCommodityDto?> GetByIdAsync(Guid id);
            Task<CountryCommodityDto> CreateAsync(CountryCommodityDto dto);
            Task<bool> UpdateAsync(Guid id, CountryCommodityDto dto);
            Task<bool> DeleteAsync(Guid id);
            Task<bool> MappingExistsAsync(string countryCode);
        }

}
