using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ITreatmentIngredientRepository
    {
        Task<IEnumerable<TreatmentIngredientDto>> GetAllAsync();
        Task<TreatmentIngredientDto?> GetByIdAsync(Guid id);
        Task<TreatmentIngredientDto> CreateAsync(TreatmentIngredientDto dto);
        Task UpdateAsync(TreatmentIngredientDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}