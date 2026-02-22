using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ITreatmentConcentrationRepository
    {
        Task<IEnumerable<TreatmentConcentrationDto>> GetAllAsync();
        Task<TreatmentConcentrationDto?> GetByIdAsync(Guid id);
        Task<TreatmentConcentrationDto> CreateAsync(TreatmentConcentrationDto dto);
        Task UpdateAsync(TreatmentConcentrationDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}