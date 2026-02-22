using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class TreatmentConcentrationRepository : ITreatmentConcentrationRepository
    {
        private readonly ExdocContext _context;

        public TreatmentConcentrationRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<TreatmentConcentrationDto>> GetAllAsync()
        {
            return await _context.TreatmentConcentrations
                .Select(t => new TreatmentConcentrationDto
                {
                    ConcentrationUnitId = t.ConcentrationUnitId,
                    UnitCode = t.UnitCode,
                    Description = t.Description
                }).ToListAsync();
        }

        public async Task<TreatmentConcentrationDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.TreatmentConcentrations.FindAsync(id);
            if (entity == null) return null;

            return new TreatmentConcentrationDto
            {
                ConcentrationUnitId = entity.ConcentrationUnitId,
                UnitCode = entity.UnitCode,
                Description = entity.Description
            };
        }

        public async Task<TreatmentConcentrationDto> CreateAsync(TreatmentConcentrationDto dto)
        {
            var entity = new TreatmentConcentration
            {
                ConcentrationUnitId = dto.ConcentrationUnitId == Guid.Empty ? Guid.NewGuid() : dto.ConcentrationUnitId,
                UnitCode = dto.UnitCode,
                Description = dto.Description
            };

            _context.TreatmentConcentrations.Add(entity);
            await _context.SaveChangesAsync();

            dto.ConcentrationUnitId = entity.ConcentrationUnitId;
            return dto;
        }

        public async Task UpdateAsync(TreatmentConcentrationDto dto)
        {
            var entity = await _context.TreatmentConcentrations.FindAsync(dto.ConcentrationUnitId);
            if (entity != null)
            {
                entity.UnitCode = dto.UnitCode;
                entity.Description = dto.Description;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.TreatmentConcentrations.FindAsync(id);
            if (entity != null)
            {
                _context.TreatmentConcentrations.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.TreatmentConcentrations.AnyAsync(e => e.ConcentrationUnitId == id);
        }
    }
}