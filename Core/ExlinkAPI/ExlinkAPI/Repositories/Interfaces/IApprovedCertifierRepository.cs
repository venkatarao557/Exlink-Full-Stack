using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IApprovedCertifierRepository
    {
        Task<IEnumerable<ApprovedCertifierDto>> GetAllAsync();
        Task<ApprovedCertifierDto?> GetByIdAsync(Guid id);
        Task<ApprovedCertifierDto> CreateAsync(ApprovedCertifierDto certifierDto);
        Task<bool> UpdateAsync(Guid id, ApprovedCertifierDto certifierDto);
        Task<bool> DeleteAsync(Guid id);
    }
}
