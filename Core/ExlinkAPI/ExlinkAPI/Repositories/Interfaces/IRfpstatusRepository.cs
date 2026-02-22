using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IRfpstatusRepository
    {
        Task<IEnumerable<RfpstatusDto>> GetAllAsync();
        Task<RfpstatusDto?> GetByIdAsync(Guid id);
        Task<RfpstatusDto> CreateAsync(RfpstatusDto dto);
        Task<bool> UpdateAsync(Guid id, RfpstatusDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}