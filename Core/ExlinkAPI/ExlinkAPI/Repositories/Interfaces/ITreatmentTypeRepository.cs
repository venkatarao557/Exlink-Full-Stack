using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ITreatmentTypeRepository
    {
        Task<IEnumerable<TreatmentTypeDto>> GetAllAsync();
        Task<TreatmentTypeDto?> GetByIdAsync(Guid id);
        Task<TreatmentTypeDto> CreateAsync(TreatmentTypeDto dto);
        Task UpdateAsync(TreatmentTypeDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}