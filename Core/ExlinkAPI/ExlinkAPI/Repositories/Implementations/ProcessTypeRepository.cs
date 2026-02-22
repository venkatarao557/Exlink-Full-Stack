using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class ProcessTypeRepository : IProcessTypeRepository
    {
        private readonly ExdocContext _context;

        public ProcessTypeRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ProcessTypeDto>> GetAllAsync()
        {
            return await _context.ProcessTypes
                .Select(p => new ProcessTypeDto
                {
                    ProcessTypeId = p.ProcessTypeId,
                    ProcessTypeCode = p.ProcessTypeCode,
                    Description = p.Description
                }).ToListAsync();
        }

        public async Task<ProcessTypeDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.ProcessTypes.FindAsync(id);
            if (entity == null) return null;

            return new ProcessTypeDto
            {
                ProcessTypeId = entity.ProcessTypeId,
                ProcessTypeCode = entity.ProcessTypeCode,
                Description = entity.Description
            };
        }

        public async Task<ProcessTypeDto> CreateAsync(ProcessTypeDto dto)
        {
            var entity = new ProcessType
            {
                ProcessTypeId = Guid.NewGuid(),
                ProcessTypeCode = dto.ProcessTypeCode,
                Description = dto.Description
            };

            _context.ProcessTypes.Add(entity);
            await _context.SaveChangesAsync();

            dto.ProcessTypeId = entity.ProcessTypeId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, ProcessTypeDto dto)
        {
            var entity = await _context.ProcessTypes.FindAsync(id);
            if (entity == null) return false;

            entity.ProcessTypeCode = dto.ProcessTypeCode;
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
            var entity = await _context.ProcessTypes.FindAsync(id);
            if (entity == null) return false;

            _context.ProcessTypes.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}