using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IProductUseIndicatorRepository
    {
        Task<IEnumerable<ProductUseIndicatorDto>> GetAllAsync();
        Task<ProductUseIndicatorDto?> GetByIdAsync(Guid id);
        Task<ProductUseIndicatorDto> CreateAsync(ProductUseIndicatorDto dto);
        Task<bool> UpdateAsync(Guid id, ProductUseIndicatorDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}