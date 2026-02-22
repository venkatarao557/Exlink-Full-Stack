using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IPackageTypeRepository
    {
        Task<IEnumerable<PackageTypeDto>> GetAllAsync();
        Task<PackageTypeDto?> GetByIdAsync(Guid id);
        Task<PackageTypeDto> CreateAsync(PackageTypeDto dto);
        Task<bool> UpdateAsync(Guid id, PackageTypeDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}