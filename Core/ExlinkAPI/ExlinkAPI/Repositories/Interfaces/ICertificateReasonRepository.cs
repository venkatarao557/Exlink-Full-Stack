using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICertificateReasonRepository
    {
        Task<IEnumerable<CertificateReasonDto>> GetAllAsync();
        Task<CertificateReasonDto?> GetByIdAsync(Guid id);
        Task<CertificateReasonDto?> GetByCodeAsync(int code);
        Task<CertificateReasonDto> CreateAsync(CertificateReasonDto reasonDto);
        Task<bool> UpdateAsync(Guid id, CertificateReasonDto reasonDto);
        Task<bool> DeleteAsync(Guid id);
        Task<bool> ExistsAsync(int code);
    }
}
