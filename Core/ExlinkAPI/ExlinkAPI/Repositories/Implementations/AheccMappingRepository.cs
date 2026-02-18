using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class AheccMappingRepository : IAheccMappingRepository
    {
        private readonly ExdocContext _context;

        public AheccMappingRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<AheccproductMappingDto>> GetAllAsync()
        {
            return await _context.AheccproductMappings
                .Select(m => new AheccproductMappingDto
                {
                    MappingId = m.MappingId,
                    Ahecc = m.Ahecc,
                    CutCode = m.CutCode,
                    ProductTypeCode = m.ProductTypeCode,
                    Description = m.Description
                }).ToListAsync();
        }

        public async Task<IEnumerable<AheccproductMappingDto>> SearchByAheccAsync(string ahecc)
        {
            return await _context.AheccproductMappings
                .Where(m => m.Ahecc == ahecc)
                .Select(m => new AheccproductMappingDto
                {
                    MappingId = m.MappingId,
                    Ahecc = m.Ahecc,
                    CutCode = m.CutCode,
                    ProductTypeCode = m.ProductTypeCode,
                    Description = m.Description
                }).ToListAsync();
        }

        public async Task<AheccproductMappingDto> CreateAsync(AheccproductMappingDto mappingDto)
        {
            var entity = new AheccproductMapping
            {
                MappingId = mappingDto.MappingId == Guid.Empty ? Guid.NewGuid() : mappingDto.MappingId,
                Ahecc = mappingDto.Ahecc,
                CutCode = mappingDto.CutCode,
                ProductTypeCode = mappingDto.ProductTypeCode,
                Description = mappingDto.Description
            };

            _context.AheccproductMappings.Add(entity);
            await _context.SaveChangesAsync();

            mappingDto.MappingId = entity.MappingId;
            return mappingDto;
        }
    }
}