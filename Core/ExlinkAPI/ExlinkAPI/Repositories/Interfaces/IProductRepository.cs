using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IProductRepository
    {
        Task<IEnumerable<ProductDto>> GetAllAsync();
        Task<ProductDto?> GetByIdAsync(Guid id);
        Task<ProductDto> CreateAsync(ProductDto dto);
        Task<bool> UpdateAsync(Guid id, ProductDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}