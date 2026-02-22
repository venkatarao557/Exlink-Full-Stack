using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IWeightUnitShortRepository
    {
        Task<IEnumerable<WeightUnitShortDto>> GetAllAsync();
        Task<WeightUnitShortDto?> GetByIdAsync(Guid id);
        Task<WeightUnitShortDto> CreateAsync(WeightUnitShortDto dto);
        Task UpdateAsync(WeightUnitShortDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}