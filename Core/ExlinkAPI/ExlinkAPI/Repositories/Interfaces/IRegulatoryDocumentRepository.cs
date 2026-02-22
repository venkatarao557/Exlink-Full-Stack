using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IRegulatoryDocumentRepository
    {
        Task<IEnumerable<RegulatoryDocumentDto>> GetAllAsync();
        Task<RegulatoryDocumentDto?> GetByIdAsync(Guid id);
        Task<RegulatoryDocumentDto> CreateAsync(RegulatoryDocumentDto dto);
        Task<bool> UpdateAsync(Guid id, RegulatoryDocumentDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}