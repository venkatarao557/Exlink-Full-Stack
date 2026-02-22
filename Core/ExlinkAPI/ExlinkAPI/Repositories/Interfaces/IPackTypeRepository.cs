using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IPackTypeRepository
    {
        Task<IEnumerable<PackTypeDto>> GetAllAsync();
        Task<PackTypeDto?> GetByIdAsync(Guid id);
        Task<PackTypeDto> CreateAsync(PackTypeDto dto);
        Task<bool> UpdateAsync(Guid id, PackTypeDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}