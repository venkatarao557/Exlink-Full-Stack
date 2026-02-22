using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IRegionalOfficeRepository
    {
        Task<IEnumerable<RegionalOfficeDto>> GetAllAsync();
        Task<RegionalOfficeDto?> GetByIdAsync(Guid id);
        Task<RegionalOfficeDto> CreateAsync(RegionalOfficeDto dto);
        Task<bool> UpdateAsync(Guid id, RegionalOfficeDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}