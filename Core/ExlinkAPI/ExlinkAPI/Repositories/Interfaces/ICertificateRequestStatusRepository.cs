using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICertificateRequestStatusRepository
    {
        Task<IEnumerable<CertificateRequestStatusDto>> GetAllAsync();
        Task<CertificateRequestStatusDto?> GetByIdAsync(Guid id);
        Task<CertificateRequestStatusDto> CreateAsync(CertificateRequestStatusDto statusDto);
        Task<bool> UpdateAsync(Guid id, CertificateRequestStatusDto statusDto);
        Task<bool> DeleteAsync(Guid id);
        Task<bool> CodeExistsAsync(string code);
    }
}
