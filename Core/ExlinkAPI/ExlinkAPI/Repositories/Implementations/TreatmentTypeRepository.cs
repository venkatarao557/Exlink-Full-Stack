using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class TreatmentTypeRepository : ITreatmentTypeRepository
    {
        private readonly ExdocContext _context;

        public TreatmentTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<TreatmentTypeDto>> GetAllAsync()
        {
            return await _context.TreatmentTypes
                .Select(t => new TreatmentTypeDto
                {
                    TreatmentTypeId = t.TreatmentTypeId,
                    TreatmentTypeCode = t.TreatmentTypeCode,
                    Description = t.Description
                }).ToListAsync();
        }

        public async Task<TreatmentTypeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.TreatmentTypes.FindAsync(id);
            if (entity == null) return null;

            return new TreatmentTypeDto
            {
                TreatmentTypeId = entity.TreatmentTypeId,
                TreatmentTypeCode = entity.TreatmentTypeCode,
                Description = entity.Description
            };
        }

        public async Task<TreatmentTypeDto> CreateAsync(TreatmentTypeDto dto)
        {
            var entity = new TreatmentType
            {
                TreatmentTypeId = dto.TreatmentTypeId == Guid.Empty ? Guid.NewGuid() : dto.TreatmentTypeId,
                TreatmentTypeCode = dto.TreatmentTypeCode,
                Description = dto.Description
            };

            _context.TreatmentTypes.Add(entity);
            await _context.SaveChangesAsync();

            dto.TreatmentTypeId = entity.TreatmentTypeId;
            return dto;
        }

        public async Task UpdateAsync(TreatmentTypeDto dto)
        {
            var entity = await _context.TreatmentTypes.FindAsync(dto.TreatmentTypeId);
            if (entity != null)
            {
                entity.TreatmentTypeCode = dto.TreatmentTypeCode;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.TreatmentTypes.FindAsync(id);
            if (entity != null)
            {
                _context.TreatmentTypes.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.TreatmentTypes.AnyAsync(e => e.TreatmentTypeId == id);
        }
    }
}