using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class WeightUnitAlternateRepository : IWeightUnitAlternateRepository
    {
        private readonly ExdocContext _context;

        public WeightUnitAlternateRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<WeightUnitAlternateDto>> GetAllAsync()
        {
            return await _context.WeightUnitAlternates
                .Select(w => new WeightUnitAlternateDto
                {
                    WeightUnitAltId = w.WeightUnitAltId,
                    WeightUnit = w.WeightUnit,
                    Description = w.Description
                }).ToListAsync();
        }

        public async Task<WeightUnitAlternateDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.WeightUnitAlternates.FindAsync(id);
            if (entity == null) return null;

            return new WeightUnitAlternateDto
            {
                WeightUnitAltId = entity.WeightUnitAltId,
                WeightUnit = entity.WeightUnit,
                Description = entity.Description
            };
        }

        public async Task<WeightUnitAlternateDto> CreateAsync(WeightUnitAlternateDto dto)
        {
            var entity = new WeightUnitAlternate
            {
                WeightUnitAltId = dto.WeightUnitAltId == Guid.Empty ? Guid.NewGuid() : dto.WeightUnitAltId,
                WeightUnit = dto.WeightUnit,
                Description = dto.Description
            };

            _context.WeightUnitAlternates.Add(entity);
            await _context.SaveChangesAsync();

            dto.WeightUnitAltId = entity.WeightUnitAltId;
            return dto;
        }

        public async Task UpdateAsync(WeightUnitAlternateDto dto)
        {
            var entity = await _context.WeightUnitAlternates.FindAsync(dto.WeightUnitAltId);
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
            var entity = await _context.WeightUnitAlternates.FindAsync(id);
            if (entity != null)
            {
                _context.WeightUnitAlternates.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.WeightUnitAlternates.AnyAsync(e => e.WeightUnitAltId == id);
        }
    }
}