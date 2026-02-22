using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class UsTerritoryRepository : IUsTerritoryRepository
    {
        private readonly ExdocContext _context;

        public UsTerritoryRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<UsTerritoryDto>> GetAllAsync()
        {
            return await _context.Usterritories
                .Select(u => new UsTerritoryDto
                {
                    UsTerritoryId = u.UsterritoryId,
                    CountryCode = u.CountryCode,
                    CountryName = u.CountryName
                }).ToListAsync();
        }

        public async Task<UsTerritoryDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.Usterritories.FindAsync(id);
            if (entity == null) return null;

            return new UsTerritoryDto
            {
                UsTerritoryId = entity.UsterritoryId,
                CountryCode = entity.CountryCode,
                CountryName = entity.CountryName
            };
        }

        public async Task<UsTerritoryDto> CreateAsync(UsTerritoryDto dto)
        {
            var entity = new Usterritory
            {
                UsterritoryId = dto.UsTerritoryId == Guid.Empty ? Guid.NewGuid() : dto.UsTerritoryId,
                CountryCode = dto.CountryCode,
                CountryName = dto.CountryName
            };

            _context.Usterritories.Add(entity);
            await _context.SaveChangesAsync();

            dto.UsTerritoryId = entity.UsterritoryId;
            return dto;
        }

        public async Task UpdateAsync(UsTerritoryDto dto)
        {
            var entity = await _context.Usterritories.FindAsync(dto.UsTerritoryId);
            if (entity != null)
            {
                entity.CountryCode = dto.CountryCode;
                entity.CountryName = dto.CountryName;
                
                _context.Entry(entity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(Guid id)
        {
            var entity = await _context.Usterritories.FindAsync(id);
            if (entity != null)
            {
                _context.Usterritories.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<bool> ExistsAsync(Guid id)
        {
            return await _context.Usterritories.AnyAsync(e => e.UsterritoryId == id);
        }
    }
}