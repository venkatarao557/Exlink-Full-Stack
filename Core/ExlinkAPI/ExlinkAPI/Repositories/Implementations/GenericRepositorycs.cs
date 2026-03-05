using AutoMapper;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class GenericRepository<TEntity, TDto> : IGenericRepository<TEntity, TDto>
        where TEntity : class
    {
        protected readonly ExdocContext _context;
        protected readonly IMapper _mapper;
        protected readonly DbSet<TEntity> _dbSet;

        public GenericRepository(ExdocContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _dbSet = _context.Set<TEntity>();
        }

        public async Task<IEnumerable<TDto>> GetAllAsync()
        {
            var entities = await _dbSet.AsNoTracking().ToListAsync();
            return _mapper.Map<IEnumerable<TDto>>(entities);
        }

        public async Task<TDto> CreateAsync(TDto dto)
        {
            var entity = _mapper.Map<TEntity>(dto);
            await _dbSet.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<TDto>(entity);
        }

        public async Task<TDto?> GetByIdAsync(Guid id)
        {
            // Find the entity by its Primary Key
            var entity = await _dbSet.FindAsync(id);

            if (entity == null)
            {
                return default(TDto?);
            }

            // Map the entity to your DTO
            return _mapper.Map<TDto>(entity);
        }

        public async Task<bool> DeleteAsync(Guid id)
        {
            // Locate the entity first
            var entity = await _dbSet.FindAsync(id);

            if (entity == null)
            {
                return false; // Record not found
            }

            // Remove from the context
            _dbSet.Remove(entity);

            // Persist changes to SQL Server
            var result = await _context.SaveChangesAsync();

            // Return true if at least one row was affected
            return result > 0;
        }

        Task<bool> IGenericRepository<TEntity, TDto>.UpdateAsync(Guid id, TDto dto)
        {
            throw new NotImplementedException();
        }
    }
}