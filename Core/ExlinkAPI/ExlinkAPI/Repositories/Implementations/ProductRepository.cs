using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class ProductRepository : IProductRepository
    {
        private readonly ExdocContext _context;

        public ProductRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ProductDto>> GetAllAsync()
        {
            return await _context.Products
                .Include(p => p.CommodityCodeNavigation)
                .Include(p => p.PreservationCodeNavigation)
                .Include(p => p.PackTypeCodeNavigation)
                .Select(p => new ProductDto
                {
                    ProductId = p.ProductId,
                    CommodityCode = p.CommodityCode,
                    CommodityDescription = p.CommodityCodeNavigation.Description,
                    PreservationCode = p.PreservationCode,
                    PreservationDescription = p.PreservationCodeNavigation.Description,
                    ProductTypeCode = p.ProductTypeCode,
                    PackTypeCode = p.PackTypeCode,
                    PackTypeDescription = p.PackTypeCodeNavigation.Description,
                    SupplementaryCode = p.SupplementaryCode
                }).ToListAsync();
        }

        public async Task<ProductDto?> GetByIdAsync(Guid id)
        {
            var p = await _context.Products
                .Include(p => p.CommodityCodeNavigation)
                .Include(p => p.PreservationCodeNavigation)
                .Include(p => p.PackTypeCodeNavigation)
                .FirstOrDefaultAsync(m => m.ProductId == id);

            if (p == null) return null;

            return new ProductDto
            {
                ProductId = p.ProductId,
                CommodityCode = p.CommodityCode,
                PreservationCode = p.PreservationCode,
                ProductTypeCode = p.ProductTypeCode,
                PackTypeCode = p.PackTypeCode,
                SupplementaryCode = p.SupplementaryCode
            };
        }

        public async Task<ProductDto> CreateAsync(ProductDto dto)
        {
            var entity = new Product
            {
                ProductId = Guid.NewGuid(),
                CommodityCode = dto.CommodityCode,
                PreservationCode = dto.PreservationCode,
                ProductTypeCode = dto.ProductTypeCode,
                PackTypeCode = dto.PackTypeCode,
                SupplementaryCode = dto.SupplementaryCode
            };

            _context.Products.Add(entity);
            await _context.SaveChangesAsync();

            dto.ProductId = entity.ProductId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, ProductDto dto)
        {
            var entity = await _context.Products.FindAsync(id);
            if (entity == null) return false;

            entity.CommodityCode = dto.CommodityCode;
            entity.PreservationCode = dto.PreservationCode;
            entity.ProductTypeCode = dto.ProductTypeCode;
            entity.PackTypeCode = dto.PackTypeCode;
            entity.SupplementaryCode = dto.SupplementaryCode;

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
            var entity = await _context.Products.FindAsync(id);
            if (entity == null) return false;

            _context.Products.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}