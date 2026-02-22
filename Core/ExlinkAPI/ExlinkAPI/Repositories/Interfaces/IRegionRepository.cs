using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IRegionRepository
    {
        Task<IEnumerable<RegionDto>> GetAllAsync();
        Task<RegionDto?> GetByIdAsync(Guid id);
        Task<RegionDto> CreateAsync(RegionDto dto);
        Task<bool> UpdateAsync(Guid id, RegionDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}