
using ExlinkAPI.Models;

namespace ExlinkAPI.Repositories.Interfaces
{
    public interface IDeclarationIndicatorRepository
    {
        Task<IEnumerable<DeclarationIndicator>> GetAllAsync();
        Task<DeclarationIndicator?> GetByIdAsync(Guid id);
        Task<DeclarationIndicator> AddAsync(DeclarationIndicator entity);
        Task UpdateAsync(DeclarationIndicator entity);
        Task DeleteAsync(Guid id);
        Task<bool> ExistsAsync(Guid id);
    }
}