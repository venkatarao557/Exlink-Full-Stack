using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class PreservationTypeRepository : IPreservationTypeRepository
    {
        private readonly ExdocContext _context;

        public PreservationTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PreservationTypeDto>> GetAllAsync()
        {
            return await _context.PreservationTypes
                .Select(p => new PreservationTypeDto
                {
                    PreservationTypeId = p.PreservationTypeId,
                    PreservationCode = p.PreservationCode,
                    Description = p.Description
                }).ToListAsync();
        }

        public async Task<PreservationTypeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.PreservationTypes.FindAsync(id);
            if (entity == null) return null;

            return new PreservationTypeDto
            {
                PreservationTypeId = entity.PreservationTypeId,
                PreservationCode = entity.PreservationCode,
                Description = entity.Description
            };
        }

        public async Task<PreservationTypeDto> CreateAsync(PreservationTypeDto dto)
        {
            var entity = new PreservationType
            {
                PreservationTypeId = Guid.NewGuid(),
                PreservationCode = dto.PreservationCode,
                Description = dto.Description
            };

            _context.PreservationTypes.Add(entity);
            await _context.SaveChangesAsync();

            dto.PreservationTypeId = entity.PreservationTypeId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, PreservationTypeDto dto)
        {
            var entity = await _context.PreservationTypes.FindAsync(id);
            if (entity == null) return false;

            entity.PreservationCode = dto.PreservationCode;
            entity.Description = dto.Description;

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
            var entity = await _context.PreservationTypes.FindAsync(id);
            if (entity == null) return false;

            _context.PreservationTypes.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}