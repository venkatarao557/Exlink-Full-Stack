using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IProcessTypeRepository
    {
        Task<IEnumerable<ProcessTypeDto>> GetAllAsync();
        Task<ProcessTypeDto?> GetByIdAsync(Guid id);
        Task<ProcessTypeDto> CreateAsync(ProcessTypeDto dto);
        Task<bool> UpdateAsync(Guid id, ProcessTypeDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}