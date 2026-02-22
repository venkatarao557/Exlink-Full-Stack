using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IWeightUnitAlternateRepository
    {
        Task<IEnumerable<WeightUnitAlternateDto>> GetAllAsync();
        Task<WeightUnitAlternateDto?> GetByIdAsync(Guid id);
        Task<WeightUnitAlternateDto> CreateAsync(WeightUnitAlternateDto dto);
        Task UpdateAsync(WeightUnitAlternateDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}