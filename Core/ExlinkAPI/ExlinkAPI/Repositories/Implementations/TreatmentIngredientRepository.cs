using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class TreatmentIngredientRepository : ITreatmentIngredientRepository
    {
        private readonly ExdocContext _context;

        public TreatmentIngredientRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<TreatmentIngredientDto>> GetAllAsync()
        {
            return await _context.TreatmentIngredients
                .Select(i => new TreatmentIngredientDto
                {
                    IngredientId = i.IngredientId,
                    IngredientCode = i.IngredientCode,
                    Description = i.Description
                }).ToListAsync();
        }

        public async Task<TreatmentIngredientDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.TreatmentIngredients.FindAsync(id);
            if (entity == null) return null;

            return new TreatmentIngredientDto
            {
                IngredientId = entity.IngredientId,
                IngredientCode = entity.IngredientCode,
                Description = entity.Description
            };
        }

        public async Task<TreatmentIngredientDto> CreateAsync(TreatmentIngredientDto dto)
        {
            var entity = new TreatmentIngredient
            {
                IngredientId = dto.IngredientId == Guid.Empty ? Guid.NewGuid() : dto.IngredientId,
                IngredientCode = dto.IngredientCode,
                Description = dto.Description
            };

            _context.TreatmentIngredients.Add(entity);
            await _context.SaveChangesAsync();

            dto.IngredientId = entity.IngredientId;
            return dto;
        }

        public async Task UpdateAsync(TreatmentIngredientDto dto)
        {
            var entity = await _context.TreatmentIngredients.FindAsync(dto.IngredientId);
            if (entity != null)
            {
                entity.IngredientCode = dto.IngredientCode;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.TreatmentIngredients.FindAsync(id);
            if (entity != null)
            {
                _context.TreatmentIngredients.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.TreatmentIngredients.AnyAsync(e => e.IngredientId == id);
        }
    }
}