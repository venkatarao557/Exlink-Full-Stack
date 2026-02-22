using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class LocationQualifierRepository : ILocationQualifierRepository
    {
        private readonly ExdocContext _context;

        public LocationQualifierRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<LocationQualifierDto>> GetAllAsync()
        {
            return await _context.LocationQualifiers
                .Select(l => new LocationQualifierDto
                {
                    LocationQualId = l.LocationQualId,
                    LocationQualifier = l.LocationQualifier1
                }).ToListAsync();
        }

        public async Task<LocationQualifierDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.LocationQualifiers.FindAsync(id);
            if (entity == null) return null;

            return new LocationQualifierDto
            {
                LocationQualId = entity.LocationQualId,
                LocationQualifier = entity.LocationQualifier1
            };
        }

        public async Task<LocationQualifierDto> CreateAsync(LocationQualifierDto dto)
        {
            var entity = new LocationQualifier
            {
                LocationQualId = Guid.NewGuid(),
                LocationQualifier1 = dto.LocationQualifier
            };

            _context.LocationQualifiers.Add(entity);
            await _context.SaveChangesAsync();

            dto.LocationQualId = entity.LocationQualId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, LocationQualifierDto dto)
        {
            var entity = await _context.LocationQualifiers.FindAsync(id);
            if (entity == null) return false;

            entity.LocationQualifier1 = dto.LocationQualifier;

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
            var entity = await _context.LocationQualifiers.FindAsync(id);
            if (entity == null) return false;

            _context.LocationQualifiers.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}