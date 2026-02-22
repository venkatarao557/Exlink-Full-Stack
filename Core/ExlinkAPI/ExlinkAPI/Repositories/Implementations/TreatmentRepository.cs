using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class TreatmentRepository : ITreatmentRepository
    {
        private readonly ExdocContext _context;

        public TreatmentRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<TreatmentDto>> GetAllAsync()
        {
            return await _context.Treatments
                .Select(t => new TreatmentDto
                {
                    TreatmentId = t.TreatmentId,
                    TreatmentCode = t.TreatmentCode,
                    Description = t.Description
                }).ToListAsync();
        }

        public async Task<TreatmentDto?> GetByIdAsync(Guid id)
        {
            var treatment = await _context.Treatments.FindAsync(id);
            if (treatment == null) return null;

            return new TreatmentDto
            {
                TreatmentId = treatment.TreatmentId,
                TreatmentCode = treatment.TreatmentCode,
                Description = treatment.Description
            };
        }

        public async Task<TreatmentDto> CreateAsync(TreatmentDto dto)
        {
            var entity = new Treatment
            {
                TreatmentId = dto.TreatmentId == Guid.Empty ? Guid.NewGuid() : dto.TreatmentId,
                TreatmentCode = dto.TreatmentCode,
                Description = dto.Description
            };

            _context.Treatments.Add(entity);
            await _context.SaveChangesAsync();

            dto.TreatmentId = entity.TreatmentId;
            return dto;
        }

        public async Task UpdateAsync(TreatmentDto dto)
        {
            var entity = await _context.Treatments.FindAsync(dto.TreatmentId);
            if (entity != null)
            {
                entity.TreatmentCode = dto.TreatmentCode;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.Treatments.FindAsync(id);
            if (entity != null)
            {
                _context.Treatments.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.Treatments.AnyAsync(e => e.TreatmentId == id);
        }
    }
}