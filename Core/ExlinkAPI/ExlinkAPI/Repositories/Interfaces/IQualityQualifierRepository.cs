using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IQualityQualifierRepository
    {
        Task<IEnumerable<QualityQualifierDto>> GetAllAsync();
        Task<QualityQualifierDto?> GetByIdAsync(Guid id);
        Task<QualityQualifierDto> CreateAsync(QualityQualifierDto dto);
        Task<bool> UpdateAsync(Guid id, QualityQualifierDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}