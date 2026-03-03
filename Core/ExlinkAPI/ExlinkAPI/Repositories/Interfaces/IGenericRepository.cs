namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IGenericRepository<TEntity, TDto> where TEntity : class
    {
        Task<IEnumerable<TDto>> GetAllAsync();
        Task<TDto?> GetByIdAsync(Guid id);
        Task<TDto> CreateAsync(TDto dto);
        Task<bool> DeleteAsync(Guid id);
    }
}