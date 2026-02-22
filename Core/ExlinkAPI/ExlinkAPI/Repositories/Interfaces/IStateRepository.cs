using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IStateRepository
    {
        Task<IEnumerable<StateDto>> GetAllAsync();
        Task<StateDto?> GetByIdAsync(Guid id);
        Task<StateDto> CreateAsync(StateDto dto);
        Task<bool> UpdateAsync(Guid id, StateDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}