using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IPortRepository
    {
        Task<IEnumerable<PortDto>> GetAllAsync();
        Task<PortDto?> GetByIdAsync(Guid id);
        Task<PortDto> CreateAsync(PortDto dto);
        Task<bool> UpdateAsync(Guid id, PortDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}