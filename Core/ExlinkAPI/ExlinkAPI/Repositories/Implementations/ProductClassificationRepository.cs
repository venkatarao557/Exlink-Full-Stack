using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class ProductClassificationRepository : IProductClassificationRepository
    {
        private readonly ExdocContext _context;

        public ProductClassificationRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ProductClassificationDto>> GetAllAsync()
        {
            return await _context.ProductClassifications
                .Select(p => new ProductClassificationDto
                {
                    ProductClassificationId = p.ProductClassificationId,
                    Cncode = p.Cncode,
                    Ahecc = p.Ahecc,
                    Description = p.Description,
                    StartDate = p.StartDate,
                    EndDate = p.EndDate
                }).ToListAsync();
        }

        public async Task<ProductClassificationDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.ProductClassifications.FindAsync(id);
            if (entity == null) return null;

            return new ProductClassificationDto
            {
                ProductClassificationId = entity.ProductClassificationId,
                Cncode = entity.Cncode,
                Ahecc = entity.Ahecc,
                Description = entity.Description,
                StartDate = entity.StartDate,
                EndDate = entity.EndDate
            };
        }

        public async Task<ProductClassificationDto> CreateAsync(ProductClassificationDto dto)
        {
            var entity = new ProductClassification
            {
                ProductClassificationId = Guid.NewGuid(),
                Cncode = dto.Cncode,
                Ahecc = dto.Ahecc,
                Description = dto.Description,
                StartDate = dto.StartDate,
                EndDate = dto.EndDate
            };

            _context.ProductClassifications.Add(entity);
            await _context.SaveChangesAsync();

            dto.ProductClassificationId = entity.ProductClassificationId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, ProductClassificationDto dto)
        {
            var entity = await _context.ProductClassifications.FindAsync(id);
            if (entity == null) return false;

            entity.Cncode = dto.Cncode;
            entity.Ahecc = dto.Ahecc;
            entity.Description = dto.Description;
            entity.StartDate = dto.StartDate;
            entity.EndDate = dto.EndDate;

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
            var entity = await _context.ProductClassifications.FindAsync(id);
            if (entity == null) return false;

            _context.ProductClassifications.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}