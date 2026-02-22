using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IUsTerritoryRepository
    {
        Task<IEnumerable<UsTerritoryDto>> GetAllAsync();
        Task<UsTerritoryDto?> GetByIdAsync(Guid id);
        Task<UsTerritoryDto> CreateAsync(UsTerritoryDto dto);
        Task UpdateAsync(UsTerritoryDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}