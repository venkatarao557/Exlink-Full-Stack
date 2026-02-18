using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IAheccMappingRepository
    {
        Task<IEnumerable<AheccproductMappingDto>> GetAllAsync();
        Task<IEnumerable<AheccproductMappingDto>> SearchByAheccAsync(string ahecc);
        Task<AheccproductMappingDto> CreateAsync(AheccproductMappingDto mappingDto);
    }
}
