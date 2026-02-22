using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ILocationQualifierRepository
    {
        Task<IEnumerable<LocationQualifierDto>> GetAllAsync();
        Task<LocationQualifierDto?> GetByIdAsync(Guid id);
        Task<LocationQualifierDto> CreateAsync(LocationQualifierDto dto);
        Task<bool> UpdateAsync(Guid id, LocationQualifierDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}