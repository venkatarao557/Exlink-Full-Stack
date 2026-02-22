using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IPreservationTypeRepository
    {
        Task<IEnumerable<PreservationTypeDto>> GetAllAsync();
        Task<PreservationTypeDto?> GetByIdAsync(Guid id);
        Task<PreservationTypeDto> CreateAsync(PreservationTypeDto dto);
        Task<bool> UpdateAsync(Guid id, PreservationTypeDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}