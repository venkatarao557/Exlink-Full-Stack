using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class WeightUnitShortRepository : IWeightUnitShortRepository
    {
        private readonly ExdocContext _context;

        public WeightUnitShortRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<WeightUnitShortDto>> GetAllAsync()
        {
            return await _context.WeightUnitShorts
                .Select(w => new WeightUnitShortDto
                {
                    WeightUnitShortId = w.WeightUnitShortId,
                    WeightUnit = w.WeightUnit,
                    Description = w.Description
                }).ToListAsync();
        }

        public async Task<WeightUnitShortDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.WeightUnitShorts.FindAsync(id);
            if (entity == null) return null;

            return new WeightUnitShortDto
            {
                WeightUnitShortId = entity.WeightUnitShortId,
                WeightUnit = entity.WeightUnit,
                Description = entity.Description
            };
        }

        public async Task<WeightUnitShortDto> CreateAsync(WeightUnitShortDto dto)
        {
            var entity = new WeightUnitShort
            {
                WeightUnitShortId = dto.WeightUnitShortId == Guid.Empty ? Guid.NewGuid() : dto.WeightUnitShortId,
                WeightUnit = dto.WeightUnit,
                Description = dto.Description
            };

            _context.WeightUnitShorts.Add(entity);
            await _context.SaveChangesAsync();

            dto.WeightUnitShortId = entity.WeightUnitShortId;
            return dto;
        }

        public async Task UpdateAsync(WeightUnitShortDto dto)
        {
            var entity = await _context.WeightUnitShorts.FindAsync(dto.WeightUnitShortId);
            if (entity != null)
            {
                entity.WeightUnit = dto.WeightUnit;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.WeightUnitShorts.FindAsync(id);
            if (entity != null)
            {
                _context.WeightUnitShorts.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.WeightUnitShorts.AnyAsync(e => e.WeightUnitShortId == id);
        }
    }
}