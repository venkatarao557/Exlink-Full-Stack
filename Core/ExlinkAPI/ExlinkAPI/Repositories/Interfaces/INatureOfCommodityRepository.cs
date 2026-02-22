using ExlinkAPI.DTOs;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface INatureOfCommodityRepository
    {
        Task<IEnumerable<NatureOfCommodityDto>> GetAllAsync();
        Task<NatureOfCommodityDto?> GetByIdAsync(Guid id);
        Task<NatureOfCommodityDto> CreateAsync(NatureOfCommodityDto dto);
        Task<bool> UpdateAsync(Guid id, NatureOfCommodityDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}