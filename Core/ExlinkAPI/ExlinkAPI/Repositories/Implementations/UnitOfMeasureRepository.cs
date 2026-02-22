using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class UnitOfMeasureRepository : IUnitOfMeasureRepository
    {
        private readonly ExdocContext _context;

        public UnitOfMeasureRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<UnitOfMeasureDto>> GetAllAsync()
        {
            return await _context.UnitOfMeasures
                .Select(u => new UnitOfMeasureDto
                {
                    UnitOfMeasureId = u.Uomid,
                    UnitCode = u.UnitCode,
                    UnitType = u.UnitType,
                    Description = u.Description
                }).ToListAsync();
        }

        public async Task<UnitOfMeasureDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.UnitOfMeasures.FindAsync(id);
            if (entity == null) return null;

            return new UnitOfMeasureDto
            {
                UnitOfMeasureId = entity.Uomid,
                UnitCode = entity.UnitCode,
                UnitType = entity.UnitType,
                Description = entity.Description
            };
        }

        public async Task<UnitOfMeasureDto> CreateAsync(UnitOfMeasureDto dto)
        {
            var entity = new UnitOfMeasure
            {
                Uomid = dto.UnitOfMeasureId == Guid.Empty ? Guid.NewGuid() : dto.UnitOfMeasureId,
                UnitCode = dto.UnitCode,
                UnitType = dto.UnitType,
                Description = dto.Description
            };

            _context.UnitOfMeasures.Add(entity);
            await _context.SaveChangesAsync();

            dto.UnitOfMeasureId = entity.Uomid;
            return dto;
        }

        public async Task UpdateAsync(UnitOfMeasureDto dto)
        {
            var entity = await _context.UnitOfMeasures.FindAsync(dto.UnitOfMeasureId);
            if (entity != null)
            {
                entity.UnitCode = dto.UnitCode;
                entity.UnitType = dto.UnitType;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.UnitOfMeasures.FindAsync(id);
            if (entity != null)
            {
                _context.UnitOfMeasures.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.UnitOfMeasures.AnyAsync(e => e.Uomid == id);
        }
    }
}