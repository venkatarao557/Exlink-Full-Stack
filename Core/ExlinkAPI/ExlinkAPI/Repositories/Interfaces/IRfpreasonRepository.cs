using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IRfpreasonRepository
    {
        Task<IEnumerable<RfpreasonDto>> GetAllAsync();
        Task<RfpreasonDto?> GetByIdAsync(Guid id);
        Task<RfpreasonDto> CreateAsync(RfpreasonDto dto);
        Task<bool> UpdateAsync(Guid id, RfpreasonDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}