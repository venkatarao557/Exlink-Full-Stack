using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IUnitOfMeasureRepository
    {
        Task<IEnumerable<UnitOfMeasureDto>> GetAllAsync();
        Task<UnitOfMeasureDto?> GetByIdAsync(Guid id);
        Task<UnitOfMeasureDto> CreateAsync(UnitOfMeasureDto dto);
        Task UpdateAsync(UnitOfMeasureDto dto);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}