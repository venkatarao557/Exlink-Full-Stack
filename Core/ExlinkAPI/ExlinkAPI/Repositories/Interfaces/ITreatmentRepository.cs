using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ITreatmentRepository
    {
        Task<IEnumerable<TreatmentDto>> GetAllAsync();
        Task<TreatmentDto?> GetByIdAsync(Guid id);
        Task<TreatmentDto> CreateAsync(TreatmentDto treatmentDto);
        Task UpdateAsync(TreatmentDto treatmentDto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}