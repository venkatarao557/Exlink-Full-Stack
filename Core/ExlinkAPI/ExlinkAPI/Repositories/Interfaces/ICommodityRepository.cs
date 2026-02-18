using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface ICommodityRepository
    {
        Task<IEnumerable<CommodityDto>> GetAllAsync();
        Task<CommodityDto?> GetByIdAsync(Guid id);
        Task<CommodityDto> CreateAsync(CommodityDto commodityDto);
        Task<bool> UpdateAsync(Guid id, CommodityDto commodityDto);
        Task<bool> DeleteAsync(Guid id);
        Task<bool> CodeExistsAsync(string code);
    }
}
