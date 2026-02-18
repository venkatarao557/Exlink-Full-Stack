using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICertificatePrintIndicatorRepository
    {
        Task<IEnumerable<CertificatePrintIndicatorDto>> GetAllAsync();
        Task<CertificatePrintIndicatorDto?> GetByIdAsync(Guid id);
        Task<CertificatePrintIndicatorDto> CreateAsync(CertificatePrintIndicatorDto indicatorDto);
        Task<bool> UpdateAsync(Guid id, CertificatePrintIndicatorDto indicatorDto);
        Task<bool> DeleteAsync(Guid id);
    }
}
