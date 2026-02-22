using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ITransportModeRepository
    {
        Task<IEnumerable<TransportModeDto>> GetAllAsync();
        Task<TransportModeDto?> GetByIdAsync(Guid id);
        Task<TransportModeDto> CreateAsync(TransportModeDto transportModeDto);
        Task UpdateAsync(TransportModeDto transportModeDto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}