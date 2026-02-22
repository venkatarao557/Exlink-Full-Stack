using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class RegionalOfficeRepository : IRegionalOfficeRepository
    {
        private readonly ExdocContext _context;

        public RegionalOfficeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RegionalOfficeDto>> GetAllAsync()
        {
            return await _context.RegionalOffices
                .Select(o => new RegionalOfficeDto
                {
                    OfficeId = o.OfficeId,
                    OfficeCode = o.OfficeCode,
                    OfficeName = o.OfficeName,
                    OfficeType = o.State
                }).ToListAsync();
        }

        public async Task<RegionalOfficeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.RegionalOffices.FindAsync(id);
            if (entity == null) return null;

            return new RegionalOfficeDto
            {
                OfficeId = entity.OfficeId,
                OfficeCode = entity.OfficeCode,
                OfficeName = entity.OfficeName,
                OfficeType = entity.State
            };
        }

        public async Task<RegionalOfficeDto> CreateAsync(RegionalOfficeDto dto)
        {
            var entity = new RegionalOffice
            {
                OfficeId = Guid.NewGuid(),
                OfficeCode = dto.OfficeCode,
                OfficeName = dto.OfficeName,
                State = dto.OfficeType
            };

            _context.RegionalOffices.Add(entity);
            await _context.SaveChangesAsync();

            dto.OfficeId = entity.OfficeId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, RegionalOfficeDto dto)
        {
            var entity = await _context.RegionalOffices.FindAsync(id);
            if (entity == null) return false;

            entity.OfficeCode = dto.OfficeCode;
            entity.OfficeName = dto.OfficeName;
            entity.State = dto.OfficeType;

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
            var entity = await _context.RegionalOffices.FindAsync(id);
            if (entity == null) return false;

            _context.RegionalOffices.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}