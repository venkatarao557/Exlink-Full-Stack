using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IProductClassificationRepository
    {
        Task<IEnumerable<ProductClassificationDto>> GetAllAsync();
        Task<ProductClassificationDto?> GetByIdAsync(Guid id);
        Task<ProductClassificationDto> CreateAsync(ProductClassificationDto dto);
        Task<bool> UpdateAsync(Guid id, ProductClassificationDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}