using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class ProductUseIndicatorRepository : IProductUseIndicatorRepository
    {
        private readonly ExdocContext _context;

        public ProductUseIndicatorRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ProductUseIndicatorDto>> GetAllAsync()
        {
            return await _context.ProductUseIndicators
                .Select(p => new ProductUseIndicatorDto
                {
                    ProductUseId = p.ProductUseId,
                    UseCode = p.UseCode,
                    Description = p.Description
                }).ToListAsync();
        }

        public async Task<ProductUseIndicatorDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.ProductUseIndicators.FindAsync(id);
            if (entity == null) return null;

            return new ProductUseIndicatorDto
            {
                ProductUseId = entity.ProductUseId,
                UseCode = entity.UseCode,
                Description = entity.Description
            };
        }

        public async Task<ProductUseIndicatorDto> CreateAsync(ProductUseIndicatorDto dto)
        {
            var entity = new ProductUseIndicator
            {
                ProductUseId = Guid.NewGuid(),
                UseCode = dto.UseCode,
                Description = dto.Description
            };

            _context.ProductUseIndicators.Add(entity);
            await _context.SaveChangesAsync();

            dto.ProductUseId = entity.ProductUseId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, ProductUseIndicatorDto dto)
        {
            var entity = await _context.ProductUseIndicators.FindAsync(id);
            if (entity == null) return false;

            entity.UseCode = dto.UseCode;
            entity.Description = dto.Description;

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                return false;
            }
        }

        public async Task<bool> DeleteAsync(Guid id)
        {
            var entity = await _context.ProductUseIndicators.FindAsync(id);
            if (entity == null) return false;

            _context.ProductUseIndicators.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}